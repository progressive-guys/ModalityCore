import SwiftSyntax

extension StyleVisitor {
  /// Keeps compact switch cases together and separates multiline cases with one blank line.
  /// Attached comments count as part of each case. Checks conditional branches separately.
  func checkSwitchCaseSpacing(_ cases: SwitchCaseListSyntax) {
    for (previous, current) in zip(cases, cases.dropFirst()) {
      guard let previousCase = previous.as(SwitchCaseSyntax.self),
            let currentCase = current.as(SwitchCaseSyntax.self)
      else { continue }

      if let spacing = layout.elementSpacing(between: previousCase, and: currentCase),
         spacing.blankLines.count != spacing.required,
         let token = currentCase.firstToken(viewMode: .sourceAccurate)
      {
        report(.switchCaseSpacing, token)
      }
    }
    for element in cases {
      guard let configuration = element.as(IfConfigDeclSyntax.self) else { continue }

      for clause in configuration.clauses {
        if let branch = clause.elements?.as(SwitchCaseListSyntax.self) {
          checkSwitchCaseSpacing(branch)
        }
      }
    }
  }

  /// Reports runs of at least two concrete syntax type checks on one named expression with early exits.
  /// Restricts checks to ExprSyntax, StmtSyntax or DeclSyntax node names. Does not rewrite code.
  func checkSyntaxDispatch(_ statements: CodeBlockItemListSyntax) {
    checkDispatch(statements, rule: .preferSyntaxKindSwitch, match: syntaxDispatch)
  }

  /// Reports two or more native as? or is checks on one named value with early exits.
  /// Extra conditions, else branches and intervening statements end the run. Keeps type order.
  /// Calls and property reads are excluded because repeated evaluation can change their value.
  func checkTypeDispatch(_ statements: CodeBlockItemListSyntax) {
    checkDispatch(statements, rule: .preferTypeSwitch, match: typeDispatch)
  }

  private typealias DispatchCheck = (receiver: String, family: String, type: String, keyword: TokenSyntax)

  private func checkDispatch(
    _ statements: CodeBlockItemListSyntax,
    rule: StyleRule,
    match: (CodeBlockItemSyntax) -> DispatchCheck?
  ) {
    var run: [DispatchCheck] = []
    for statement in statements {
      guard let check = match(statement) else {
        if run.count >= 2, let first = run.first { report(rule, first.keyword) }

        run = []
        continue
      }
      if let previous = run.last,
         previous.receiver != check.receiver || previous.family != check.family
         || run.contains(where: { $0.type == check.type })
      {
        if run.count >= 2, let first = run.first { report(rule, first.keyword) }

        run = []
      }
      run.append(check)
    }
    if run.count >= 2, let first = run.first { report(rule, first.keyword) }
  }

  private func syntaxDispatch(
    _ item: CodeBlockItemSyntax
  ) -> DispatchCheck? {
    guard let statement = item.item.as(ExpressionStmtSyntax.self),
          let conditional = statement.expression.as(IfExprSyntax.self),
          conditional.elseBody == nil,
          conditional.conditions.count == 1,
          let binding = conditional.conditions.first?.condition.as(OptionalBindingConditionSyntax.self),
          binding.bindingSpecifier.tokenKind == .keyword(.let),
          let call = binding.initializer?.value.as(FunctionCallExprSyntax.self),
          call.arguments.count == 1,
          call.arguments.first?.label == nil,
          call.trailingClosure == nil,
          let method = call.calledExpression.as(MemberAccessExprSyntax.self),
          method.declName.baseName.text == "as",
          let receiver = method.base?.as(DeclReferenceExprSyntax.self),
          let argument = call.arguments.first?.expression.as(MemberAccessExprSyntax.self),
          argument.declName.baseName.text == "self",
          let type = argument.base?.as(DeclReferenceExprSyntax.self),
          let family = ["ExprSyntax", "StmtSyntax", "DeclSyntax"].first(where: {
            type.baseName.text.hasSuffix($0) && type.baseName.text != $0
          }),
          let last = conditional.body.statements.last,
          last.item.is(ReturnStmtSyntax.self) || last.item.is(ThrowStmtSyntax.self)
    else { return nil }

    return (receiver.baseName.text, family, type.baseName.text, conditional.ifKeyword)
  }

  private func typeDispatch(_ item: CodeBlockItemSyntax) -> DispatchCheck? {
    guard let statement = item.item.as(ExpressionStmtSyntax.self),
          let conditional = statement.expression.as(IfExprSyntax.self),
          conditional.elseBody == nil,
          conditional.conditions.count == 1,
          let condition = conditional.conditions.first,
          let last = conditional.body.statements.last,
          last.item.is(ReturnStmtSyntax.self) || last.item.is(ThrowStmtSyntax.self)
    else { return nil }

    let expression: ExprSyntax
    let type: TypeSyntax
    switch condition.condition {
    case .optionalBinding(let binding):
      guard let cast = binding.initializer?.value.as(AsExprSyntax.self),
            cast.questionOrExclamationMark?.tokenKind == .postfixQuestionMark
      else { return nil }

      expression = cast.expression
      type = cast.type

    case .expression(let check):
      guard let cast = check.as(IsExprSyntax.self) else { return nil }

      expression = cast.expression
      type = cast.type

    default: return nil
    }
    guard let receiver = expression.as(DeclReferenceExprSyntax.self) else { return nil }

    return (
      receiver.baseName.text,
      "native",
      type.tokens(viewMode: .sourceAccurate).map(\.text).joined(),
      conditional.ifKeyword
    )
  }
}
