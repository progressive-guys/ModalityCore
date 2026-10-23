import SwiftSyntax

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
    if Self.comparisons.contains(name), layout.startsLine(token) {
      report(.comparisonOperatorNewline, token)
    }
    if Self.arithmetic.contains(name), layout.line(token) != layout.line(right) {
      report(.arithmeticOperatorEndOfLine, token)
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
    if name == "+", left.is(StringLiteralExprSyntax.self), right.is(StringLiteralExprSyntax.self) {
      report(.concatenatedStringLiterals, token)
    }
    if Self.arithmetic.contains(name), let call = right.as(FunctionCallExprSyntax.self) {
      checkShortCall(call, operatorToken: token)
    }
  }

  func checkMember(_ node: MemberAccessExprSyntax) {
    guard let base = node.base else { return }

    if let name = base.as(DeclReferenceExprSyntax.self),
       name.baseName.text == "self",
       layout.endLine(base) != layout.line(node.period)
    {
      report(.selfMemberNewline, name.baseName)
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
    if let specialized = callee.as(GenericSpecializationExprSyntax.self) {
      callee = specialized.expression
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

  private func checkShortCall(_ call: FunctionCallExprSyntax, operatorToken: TokenSyntax) {
    guard
      call.arguments.count == 1,
      let argument = call.arguments.first,
      argument.label == nil,
      simpleProperty(argument.expression),
      call.trailingClosure == nil,
      layout.line(call) != layout.endLine(call),
      layout.compact(call.trimmedDescription).count <= 120,
      !layout.hasComments(call)
    else { return }

    report(.arithmeticCallArgumentsWrap, operatorToken)
  }

  private func simpleProperty(_ node: ExprSyntax) -> Bool {
    if node.is(DeclReferenceExprSyntax.self) { return true }

    if let member = node.as(MemberAccessExprSyntax.self), let base = member.base {
      return simpleProperty(base)
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
    if let parent = node.parent?.as(InfixOperatorExprSyntax.self),
       chainRule(parent.operator.trimmedDescription) == rule
    {
      return
    }
    let operations = chainOperations(node, rule: rule)
    let tokens = operations.compactMap { $0.operator.firstToken(viewMode: .sourceAccurate) }
    let leading = tokens.map { layout.startsLine($0) }
    if leading.contains(true), leading.contains(false) {
      report(rule, token)
    }
  }

  private func chainOperations(_ node: InfixOperatorExprSyntax, rule: StyleRule) -> [InfixOperatorExprSyntax] {
    var result: [InfixOperatorExprSyntax] = []
    if let left = node.leftOperand.as(InfixOperatorExprSyntax.self),
       chainRule(left.operator.trimmedDescription) == rule
    {
      result += chainOperations(left, rule: rule)
    }
    result.append(node)
    if let right = node.rightOperand.as(InfixOperatorExprSyntax.self),
       chainRule(right.operator.trimmedDescription) == rule
    {
      result += chainOperations(right, rule: rule)
    }
    return result
  }

  private func brokenMember(_ expression: ExprSyntax) -> Bool {
    memberChain(expression).contains { member in
      member.base.map { layout.endLine($0) != layout.line(member.period) } ?? false
    }
  }

  private func receiverCall(_ expression: ExprSyntax) -> FunctionCallExprSyntax? {
    if let call = expression.as(FunctionCallExprSyntax.self) { return call }

    if let optional = expression.as(OptionalChainingExprSyntax.self) { return receiverCall(optional.expression) }

    if let forced = expression.as(ForceUnwrapExprSyntax.self) { return receiverCall(forced.expression) }

    return nil
  }

  private func memberChain(_ expression: ExprSyntax) -> [MemberAccessExprSyntax] {
    switch expression.as(ExprSyntaxEnum.self) {
    case .memberAccessExpr(let member):
      (member.base.map(memberChain) ?? []) + [member]

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
      if let member = parent.as(MemberAccessExprSyntax.self), member.base?.id == current.id { return true }

      if let call = parent.as(FunctionCallExprSyntax.self), call.calledExpression.id == current.id {
        current = parent
      } else if parent.is(OptionalChainingExprSyntax.self)
        || parent.is(ForceUnwrapExprSyntax.self)
        || parent.is(GenericSpecializationExprSyntax.self)
        || parent.is(SubscriptCallExprSyntax.self)
      {
        current = parent
      } else {
        return false
      }
    }
    return false
  }
}
