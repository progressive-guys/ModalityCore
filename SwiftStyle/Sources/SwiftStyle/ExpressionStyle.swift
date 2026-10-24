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
    if Self.comparisons.contains(name), layout.line(token) != layout.line(right) {
      report(.comparisonOperatorNewline, token)
    }
    if !node.operator.is(AssignmentExprSyntax.self), layout.line(token) != layout.line(right) {
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
    if name == "+", left.is(StringLiteralExprSyntax.self), right.is(StringLiteralExprSyntax.self) {
      report(.concatenatedStringLiterals, token)
    }
    if let call = left.as(FunctionCallExprSyntax.self) {
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

  /// Puts the closing delimiter on its own line after multiline expression content.
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
    if prefix.allSatisfy({ $0.isWhitespace || ")]},".contains($0) }) { return }

    report(.multilineExpressionClosingDelimiter, token)
  }

  private func checkShortCall(_ call: FunctionCallExprSyntax, operatorToken: TokenSyntax) {
    guard
      call.arguments.count == 1,
      let argument = call.arguments.first,
      argument.label == nil,
      compactCallArgument(argument.expression),
      call.trailingClosure == nil,
      layout.line(call) != layout.endLine(call),
      layout.compact(call.trimmedDescription).count <= 120,
      !layout.hasComments(call)
    else { return }

    let prefix = layout.converter.location(for: call.positionAfterSkippingLeadingTrivia).column - 1
    guard prefix + layout.compact(call.trimmedDescription).count <= 120 else { return }

    report(.arithmeticCallArgumentsWrap, operatorToken)
  }

  /// Keeps single-argument arithmetic calls whole when their text fits on one line.
  private func compactCallArgument(_ expression: ExprSyntax) -> Bool {
    if let operation = expression.as(InfixOperatorExprSyntax.self) {
      return Self.arithmetic.contains(operation.operator.trimmedDescription)
    }
    return simpleProperty(expression)
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
    switch expression.as(ExprSyntaxEnum.self) {
    case .functionCallExpr(let call): call
    case .optionalChainingExpr(let optional): receiverCall(optional.expression)
    case .forceUnwrapExpr(let forced): receiverCall(forced.expression)
    default: nil
    }
  }

  private func memberChain(_ expression: ExprSyntax) -> [MemberAccessExprSyntax] {
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
