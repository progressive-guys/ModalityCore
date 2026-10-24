import Foundation
import SwiftSyntax

extension StyleVisitor {
  /// Checks one arithmetic region, including single-argument calls and explicit groups.
  func checkArithmeticPrecedence(_ node: InfixOperatorExprSyntax) {
    let root = ArithmeticLayout.root(of: ExprSyntax(node))
    let operations = ArithmeticLayout.operations(in: root)
    guard operations.first?.id == node.id,
          let expression = ArithmeticLayout(root: root, operations: operations, layout: layout),
          let token = node.operator.firstToken(viewMode: .sourceAccurate)
    else { return }

    if expression.hasInvalidWrap {
      report(.arithmeticPrecedenceWrap, token)
    }
  }
}

/// Measures source lines without changing tokens, parentheses or evaluation order.
private struct ArithmeticLayout {
  let hasInvalidWrap: Bool

  init?(root: ExprSyntax, operations: [InfixOperatorExprSyntax], layout: SourceLayout) {
    guard !layout.hasComments(root) else { return nil }

    let tokens = Array(root.tokens(viewMode: .sourceAccurate))
    guard let first = tokens.first, let last = tokens.last,
          tokens.allSatisfy({ !$0.text.contains("\n") && !$0.text.contains("\r") })
    else { return nil }

    let operators = Set(operations.compactMap { $0.operator.firstToken(viewMode: .sourceAccurate)?.id })
    var offsets: [SyntaxIdentifier: Int] = [:]
    var text = ""
    var continuations: [TokenSyntax] = []
    var previous: TokenSyntax?
    for token in tokens {
      if let previous {
        let gap = previous.trailingTrivia.description + token.leadingTrivia.description
        if layout.endLine(previous) != layout.line(token) {
          // Other layout boundaries belong to call, collection or block formatting.
          guard operators.contains(previous.id) || operators.contains(token.id) else { return nil }

          continuations.append(token)
          text += " "
        } else {
          text += gap
        }
      }
      offsets[token.id] = text.count
      text += token.text
      previous = token
    }
    guard !continuations.isEmpty else {
      hasInvalidWrap = false
      return
    }

    let firstLocation = layout.converter.location(for: first.positionAfterSkippingLeadingTrivia)
    let lastLocation = layout.converter.location(for: last.endPositionBeforeTrailingTrivia)
    let firstLine = layout.text(at: firstLocation.line)
    let lastLine = layout.text(at: lastLocation.line)
    let prefix = String(decoding: firstLine.utf8.prefix(firstLocation.column - 1), as: UTF8.self).count
    let suffix = String(decoding: lastLine.utf8.dropFirst(lastLocation.column - 1), as: UTF8.self).count
    let indent = layout.indent(first) + 2
    if prefix + text.count + suffix <= 120 || continuations.contains(where: { layout.indent($0) != indent }) {
      hasInvalidWrap = true
      return
    }

    // Wrap the outer expression before its call arguments or groups. Within one level, wrap sums first.
    hasInvalidWrap = operations.contains { operation in
      guard let token = operation.operator.firstToken(viewMode: .sourceAccurate),
            let offset = offsets[token.id],
            layout.endLine(operation.leftOperand) != layout.line(token)
            || layout.line(token) != layout.line(operation.rightOperand)
      else { return false }

      let priority = Self.wrapPriority(operation, in: root)
      let preferredOffsets = operations.compactMap { candidate -> Int? in
        guard Self.wrapPriority(candidate, in: root) < priority,
              let token = candidate.operator.firstToken(viewMode: .sourceAccurate),
              let offset = offsets[token.id]
        else { return nil }

        return offset + token.text.count
      }
      let boundaries = [0] + preferredOffsets + [text.count]
      guard let start = boundaries.last(where: { $0 <= offset }),
            let end = boundaries.first(where: { $0 > offset })
      else { return false }

      let segment = text.dropFirst(start).prefix(end - start)
      let width = segment.trimmingCharacters(in: .whitespaces).count
      return (start == 0 ? prefix : indent) + width + (end == text.count ? suffix : 0) <= 120
    }
  }

  /// Crosses only arithmetic nodes, single-argument calls, parentheses and unary expressions.
  static func root(of expression: ExprSyntax) -> ExprSyntax {
    guard let parent = expression.parent else { return expression }

    if let operation = parent.as(InfixOperatorExprSyntax.self), isArithmetic(operation) {
      return root(of: ExprSyntax(operation))
    }
    if let unary = parent.as(PrefixOperatorExprSyntax.self) {
      return root(of: ExprSyntax(unary))
    }
    if parent.is(LabeledExprSyntax.self),
       let list = parent.parent?.as(LabeledExprListSyntax.self), list.count == 1
    {
      if let call = list.parent?.as(FunctionCallExprSyntax.self), call.trailingClosure == nil {
        return root(of: ExprSyntax(call))
      }
      if let tuple = list.parent?.as(TupleExprSyntax.self) {
        return root(of: ExprSyntax(tuple))
      }
    }
    return expression
  }

  /// Returns operators in source order. Other expressions form separate regions.
  static func operations(in expression: ExprSyntax) -> [InfixOperatorExprSyntax] {
    if let operation = expression.as(InfixOperatorExprSyntax.self), isArithmetic(operation) {
      return operations(in: operation.leftOperand) + [operation] + operations(in: operation.rightOperand)
    }
    if let call = expression.as(FunctionCallExprSyntax.self), call.trailingClosure == nil,
       call.arguments.count == 1, let argument = call.arguments.first
    {
      return operations(in: argument.expression)
    }
    if let tuple = expression.as(TupleExprSyntax.self), tuple.elements.count == 1,
       let element = tuple.elements.first
    {
      return operations(in: element.expression)
    }
    if let unary = expression.as(PrefixOperatorExprSyntax.self) {
      return operations(in: unary.expression)
    }
    return []
  }

  /// Calls and explicit groups take priority over operator precedence when selecting a wrap boundary.
  private static func wrapPriority(_ operation: InfixOperatorExprSyntax, in root: ExprSyntax) -> Int {
    var depth = 0
    var current: Syntax? = Syntax(operation)
    while let parent = current, parent.id != root.id {
      if parent.is(FunctionCallExprSyntax.self) || parent.is(TupleExprSyntax.self) {
        depth += 1
      }
      current = parent.parent
    }
    return depth * 2 + (["+", "-"].contains(operation.operator.trimmedDescription) ? 0 : 1)
  }

  private static func isArithmetic(_ operation: InfixOperatorExprSyntax) -> Bool {
    ["+", "-", "*", "/", "%"].contains(operation.operator.trimmedDescription)
  }
}
