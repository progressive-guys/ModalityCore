import SwiftSyntax
import SwiftOperators

extension StyleVisitor {

  private static let arithmetic = Set(["+", "-", "*", "/", "%"])
  private static let comparisons = Set(["==", "!=", "<", ">", "<=", ">=", "~=", "~~<", "~~>", "~~<=", "~~>=", "~~=="])

  func checkBinary(_ node: InfixOperatorExprSyntax) {
    guard let token = node.operator.firstToken(viewMode: .sourceAccurate) else { return }

    let name = token.text
    let left = node.leftOperand
    let right = node.rightOperand

    if let rule = chainRule(name) {
      checkOperatorChain(node, rule: rule, token: token)
    }

    if name == "=",
       layout.line(token) != layout.line(right)
    {
      report(.assignmentRhsSameLine, token)
    }

    if Self.comparisons.contains(name), layout.line(token) != layout.line(right) {
      report(.comparisonOperatorNewline, token)
    }

    let isAssignment = node.operator.is(AssignmentExprSyntax.self)
      || OperatorTable.standardOperators.infixOperator(named: name)?.precedenceGroup == "AssignmentPrecedence"

    if !isAssignment, layout.line(token) != layout.line(right) {
      report(.binaryOperatorWrap, token)

      if Self.arithmetic.contains(name) {
        report(.arithmeticOperatorEndOfLine, token)
      }
    }

    if Self.arithmetic.contains(name) {
      checkArithmeticPrecedence(node)
    }

    if Self.arithmetic.contains(name), brokenMember(left) || brokenMember(right) {
      report(.arithmeticMemberWrap, token)
    }

    if Self.arithmetic.contains(name) || Self.comparisons.contains(name) || ["&&", "||", "??"].contains(name),
       brokenMember(right)
    {
      report(.binaryOperandMemberWrap, token)
    }

    if name == "??" {
      if layout.line(token) != layout.line(right) || brokenMember(right) {
        report(.nilCoalescingMemberWrap, token)
      }

      let operatorLine = layout.line(token)
      let lineLength = layout.text(at: operatorLine).count

      if lineLength > 120, !layout.startsLine(token) {
        report(.longNilCoalescing, token)
      }
    }

    if name == "+" {
      switch (Syntax(left).as(SyntaxEnum.self)) {
    case .stringLiteralExpr where (right.is(StringLiteralExprSyntax.self)):
      report(.concatenatedStringLiterals, token)
    default:
      break
    }
    }

    switch (Syntax(left).as(SyntaxEnum.self)) {
    case .functionCallExpr(let call):
      checkShortCall(call, operatorToken: token)
    default:
      break
    }
  }

  func checkMember(_ node: MemberAccessExprSyntax) {
    guard let base = node.base else { return }

    switch (Syntax(base).as(SyntaxEnum.self)) {
    case .declReferenceExpr(let name) where (name.baseName.text == "self") && (
      layout.endLine(base) != layout.line(node.period)
    ):
      report(.selfMemberNewline, name.baseName)
    default:
      break
    }

    guard !extendsChain(node) else { return }

    let members = memberChain(ExprSyntax(node))
    let leading = members.map { $0.base != nil && layout.startsLine($0.period) }

    guard let first = leading.firstIndex(of: true) else { return }

    let hasLaterInlineMember = leading.dropFirst(first).contains(false)

    if first >= 2 || hasLaterInlineMember {
      report(.mixedMemberChainWrap, node.firstToken(viewMode: .sourceAccurate) ?? node.period)
    }
  }

  func checkChainedCall(_ node: FunctionCallExprSyntax) {
    var callee = node.calledExpression

    switch (Syntax(callee).as(SyntaxEnum.self)) {
    case .genericSpecializationExpr(let specialized):
      callee = specialized.expression
    default:
      break
    }

    guard let member = callee.as(MemberAccessExprSyntax.self),
          let base = member.base,
          let previous = receiverCall(base)
    else { return }

    if let leftParen = node.leftParen,
       let rightParen = node.rightParen,
       layout.line(leftParen) != layout.line(rightParen),
       layout.endLine(previous) == layout.line(member.period)
    {
      report(.chainedCallArgumentsWrap, member.period)
    }

    if let closure = node.trailingClosure,
       layout.line(closure.leftBrace) != layout.line(closure.rightBrace),
       let previousClosure = previous.additionalTrailingClosures.last?.closure ?? previous.trailingClosure,
       layout.line(previousClosure.rightBrace) == layout.line(member.period)
    {
      report(.chainedClosureNewline, member.period)
    }
  }

  /// Puts the closing delimiter on its own line after multiline expression content.
  /// Allows compact arguments, casts, member access and calls after a nested closing delimiter.
  /// Allows the closing quotes of a multiline string to start the closing line.
  func checkClosingDelimiter(_ token: TokenSyntax) {
    guard token.tokenKind == .rightParen || token.tokenKind == .rightSquare,
          let expression = token.parent?.as(ExprSyntax.self)
    else { return }

    let opening: TokenSyntax? = switch expression.as(ExprSyntaxEnum.self) {
    case .functionCallExpr(let call): call.leftParen
    case .tupleExpr(let tuple): tuple.leftParen
    case .subscriptCallExpr(let subscriptCall): subscriptCall.leftSquare
    case .arrayExpr(let array): array.leftSquare
    case .dictionaryExpr(let dictionary): dictionary.leftSquare
    default: nil
    }

    guard let opening,
          layout.line(opening) != layout.line(token),
          let previous = token.previousToken(viewMode: .sourceAccurate),
          layout.endLine(previous) == layout.line(token)
    else { return }

    let location = layout.converter.location(for: token.positionAfterSkippingLeadingTrivia)
    let prefix = String(decoding: layout.text(at: location.line).utf8.prefix(location.column - 1), as: UTF8.self)

    if prefix.allSatisfy({ $0.isWhitespace || ")]},".contains($0) })
      || hasClosingContinuation(expression, before: token)
    { return }

    report(.multilineExpressionClosingDelimiter, token)
  }

  /// Checks that the final line starts by closing a nested multiline expression.
  /// Arithmetic and ternary expressions keep their own closing-line requirement.
  private func hasClosingContinuation(_ expression: ExprSyntax, before closing: TokenSyntax) -> Bool {
    let line = layout.line(closing)

    guard let first = expression.tokens(viewMode: .sourceAccurate).first(where: {
      !$0.text.isEmpty && layout.line($0) == line
    }), layout.startsLine(first)
    else { return false }

    let boundary: ExprSyntax

    switch first.tokenKind {
    case .multilineStringQuote:
      guard let literal = first.parent?.as(StringLiteralExprSyntax.self), literal.closingQuote.id == first.id
      else { return false }
      boundary = ExprSyntax(literal)

    case .rightParen, .rightSquare, .rightBrace:
      guard let nested = first.parent?.as(ExprSyntax.self),
            nested.lastToken(viewMode: .sourceAccurate)?.id == first.id
      else { return false }

      boundary = nested

    default: return false
    }

    guard layout.line(boundary) < line else { return false }

    var node: Syntax? = Syntax(boundary)

    while let current = node, current.id != expression.id {
      if ({ () -> Bool in
        switch (Syntax(current).as(SyntaxEnum.self)) {
        case .infixOperatorExpr: return true
        default: return false
        }
      }()) || ({ () -> Bool in
        switch (Syntax(current).as(SyntaxEnum.self)) {
        case .ternaryExpr: return true
        default: return false
        }
      }())
        || ({ () -> Bool in
          switch (Syntax(current).as(SyntaxEnum.self)) {
          case .sequenceExpr: return true
          default: return false
          }
        }())
      { return false }

      node = current.parent
    }

    return node?.id == expression.id
  }

  private func checkShortCall(_ call: FunctionCallExprSyntax, operatorToken: TokenSyntax) {
    guard
      call.arguments.count == 1,
      let argument = call.arguments.first,
      argument.label == nil,
      compactCallArgument(argument.expression),
      call.trailingClosure == nil,
      layout.line(call) != layout.endLine(call),
      SourceLayout.compact(call.trimmedDescription).count <= 120,
      !layout.hasComments(call)
    else { return }

    let prefix = layout.converter.location(for: call.positionAfterSkippingLeadingTrivia).column - 1

    guard prefix + SourceLayout.compact(call.trimmedDescription).count <= 120 else { return }

    report(.arithmeticCallArgumentsWrap, operatorToken)
  }

  /// Keeps single-argument arithmetic calls whole when their text fits on one line.
  private func compactCallArgument(_ expression: ExprSyntax) -> Bool {
    switch (Syntax(expression).as(SyntaxEnum.self)) {
    case .infixOperatorExpr(let operation):
      return Self.arithmetic.contains(operation.operator.trimmedDescription)
    default:
      break
    }

    return simpleProperty(expression)
  }

  private func simpleProperty(_ node: ExprSyntax) -> Bool {
    switch (Syntax(node).as(SyntaxEnum.self)) {
    case .declReferenceExpr:
      return true
    default:
      break
    }

    switch (Syntax(node).as(SyntaxEnum.self)) {
    case .memberAccessExpr(let member):
      if let base = member.base {return simpleProperty(base)
    }

    default:
      break
    }

    return false
  }

  private func chainRule(_ name: String) -> StyleRule? {
    switch name {
    case "+", "-": .mixedAdditiveExpressionWrap
    case "*", "/", "%": .mixedMultiplicativeExpressionWrap
    case "&&", "||": .mixedBooleanConditionWrap
    case "??": .mixedNilCoalescingWrap
    default: nil
    }
  }

  private func checkOperatorChain(_ node: InfixOperatorExprSyntax, rule: StyleRule, token: TokenSyntax) {
    switch (Syntax(node.parent)?.as(SyntaxEnum.self)) {
    case .infixOperatorExpr(let parent)? where (chainRule(parent.operator.trimmedDescription) == rule):
      return
    default:
      break
    }

    let operations = chainOperations(node, rule: rule)
    let tokens = operations.compactMap { $0.operator.firstToken(viewMode: .sourceAccurate) }
    let isArithmeticChain = Self.arithmetic.contains(token.text)

    let wrappedTokens = if isArithmeticChain {
      tokens.filter { token in
        guard let next = token.nextToken(viewMode: .sourceAccurate) else { return false }
        return layout.startsLine(token) || layout.line(token) != layout.line(next)
      }
    } else {
      tokens
    }

    let leading = wrappedTokens.map { layout.startsLine($0) }
    let partialWrap = isArithmeticChain && !wrappedTokens.isEmpty && wrappedTokens.count != tokens.count
    let trailingWrap = isArithmeticChain && wrappedTokens.contains { !layout.startsLine($0) }

    if partialWrap || trailingWrap || (leading.contains(true) && leading.contains(false)) {
      report(rule, token)
    }
  }

  func chainOperations(_ node: InfixOperatorExprSyntax, rule: StyleRule) -> [InfixOperatorExprSyntax] {
    var result: [InfixOperatorExprSyntax] = []

    switch (Syntax(node.leftOperand).as(SyntaxEnum.self)) {
    case .infixOperatorExpr(let left) where (chainRule(left.operator.trimmedDescription) == rule):
      result += chainOperations(left, rule: rule)
    default:
      break
    }

    result.append(node)

    switch (Syntax(node.rightOperand).as(SyntaxEnum.self)) {
    case .infixOperatorExpr(let right) where (chainRule(right.operator.trimmedDescription) == rule):
      result += chainOperations(right, rule: rule)
    default:
      break
    }

    return result
  }

  private func brokenMember(_ expression: ExprSyntax) -> Bool {
    memberChain(expression).contains { member in
      member.base.map { layout.endLine($0) != layout.line(member.period) } ?? false
    }
  }

  private func receiverCall(_ expression: ExprSyntax) -> FunctionCallExprSyntax? {
    switch expression.as(ExprSyntaxEnum.self) {
    case .functionCallExpr(let call): call
    case .optionalChainingExpr(let optional): receiverCall(optional.expression)
    case .forceUnwrapExpr(let forced): receiverCall(forced.expression)
    default: nil
    }
  }

  func memberChain(_ expression: ExprSyntax) -> [MemberAccessExprSyntax] {
    switch expression.as(ExprSyntaxEnum.self) {
    case .memberAccessExpr(let member): (member.base.map(memberChain) ?? []) + [member]
    case .functionCallExpr(let call): memberChain(call.calledExpression)
    case .subscriptCallExpr(let indexed): memberChain(indexed.calledExpression)
    case .optionalChainingExpr(let optional): memberChain(optional.expression)
    case .forceUnwrapExpr(let forced): memberChain(forced.expression)
    case .genericSpecializationExpr(let specialized): memberChain(specialized.expression)
    default: []
    }
  }

  private func extendsChain(_ node: MemberAccessExprSyntax) -> Bool {
    var current = Syntax(node)

    while let parent = current.parent {
      switch (Syntax(parent).as(SyntaxEnum.self)) {
      case .memberAccessExpr(let member) where (member.base?.id == current.id):
        return true
      default:
        break
      }

      switch (Syntax(parent).as(SyntaxEnum.self)) {
      case .functionCallExpr(let call) where (call.calledExpression.id == current.id):
        current = parent
      default:
        if ({ () -> Bool in
          switch (Syntax(parent).as(SyntaxEnum.self)) {
          case .optionalChainingExpr: return true
          default: return false
          }
        }())
        || ({ () -> Bool in
          switch (Syntax(parent).as(SyntaxEnum.self)) {
          case .forceUnwrapExpr: return true
          default: return false
          }
        }())
        || ({ () -> Bool in
          switch (Syntax(parent).as(SyntaxEnum.self)) {
          case .genericSpecializationExpr: return true
          default: return false
          }
        }())
        || ({ () -> Bool in
          switch (Syntax(parent).as(SyntaxEnum.self)) {
          case .subscriptCallExpr: return true
          default: return false
          }
        }())
      {
        current = parent
      } else {
        return false
      }
      }
    }

    return false
  }
}
