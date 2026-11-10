import Foundation
import SwiftSyntax

extension StyleVisitor {

  /// Formats an assigned receiver closure and its following calls as one continuation.
  /// Returns the accepted body opening for the native indentation check.
  @discardableResult
  func checkChainedClosureIndent(_ node: FunctionCallExprSyntax) -> Set<Int> {
    guard node.parent?.is(MemberAccessExprSyntax.self) != true,
          let binding = node.ancestor(InitializerClauseSyntax.self),
          layout.line(binding) == layout.line(node)
    else { return [] }

    var calls = [node]
    var receiver = node
    while let member = receiver.calledExpression.as(MemberAccessExprSyntax.self),
          let previous = member.base?.as(FunctionCallExprSyntax.self)
    {
      calls.append(previous)
      receiver = previous
    }

    guard calls.count > 1,
          receiver.calledExpression.is(MemberAccessExprSyntax.self),
          let closure = receiver.trailingClosure,
          let first = closure.statements.first,
          layout.line(receiver) == layout.line(closure.leftBrace),
          layout.line(closure.leftBrace) < layout.line(closure.rightBrace)
    else { return [] }

    let indent = layout.indent(node)
    var changes: [SourceEdit] = []
    let body = (layout.line(closure.leftBrace) + 1)..<layout.line(closure.rightBrace)

    changes += closureIndentEdits(body, by: indent + 4 - layout.indent(first), in: node)

    changes += closureIndentEdits(
      layout.line(closure.rightBrace)..<(layout.line(closure.rightBrace) + 1),
      by: indent + 2 - layout.indent(closure.rightBrace),
      in: node
    )

    for call in calls.dropLast() {
      guard let member = call.calledExpression.as(MemberAccessExprSyntax.self), layout.startsLine(member.period)
      else { continue }

      changes += closureIndentEdits(
        layout.line(member.period)..<(layout.endLine(call) + 1),
        by: indent + 2 - layout.indent(member.period),
        in: node
      )
    }

    guard !changes.isEmpty else { return [layout.line(first)] }

    report(.chainedClosureIndent, closure.leftBrace)

    if permitsFix(.chainedClosureIndent) { edits += changes }

    return []
  }

  /// Changes leading whitespace only. Literal contents and closing quotes keep their original columns.
  private func closureIndentEdits(_ lines: Range<Int>, by offset: Int, in node: FunctionCallExprSyntax) -> [SourceEdit] {
    guard offset != 0 else { return [] }

    let literals = node.tokens(viewMode: .sourceAccurate).compactMap { token -> ClosedRange<Int>? in
      let literal = token.ancestor(StringLiteralExprSyntax.self).map(Syntax.init)
        ?? token.ancestor(RegexLiteralExprSyntax.self).map(Syntax.init)

      guard let literal, layout.line(literal) < layout.endLine(literal) else { return nil }
      return (layout.line(literal) + 1)...layout.endLine(literal)
    }

    var result: [SourceEdit] = []
    var start = 0

    for (index, line) in layout.lines.enumerated() {
      defer { start += line.utf8.count + newline.utf8.count }

      let number = index + 1
      guard lines.contains(number), !line.trimmingCharacters(in: .whitespaces).isEmpty,
            !literals.contains(where: { $0.contains(number) })
      else { continue }

      let width = line.prefix { $0 == " " || $0 == "\t" }.utf8.count
      result.append(
        SourceEdit(range: start..<(start + width), replacement: String(repeating: " ", count: max(0, width + offset)))
      )
    }
    return result
  }
}
