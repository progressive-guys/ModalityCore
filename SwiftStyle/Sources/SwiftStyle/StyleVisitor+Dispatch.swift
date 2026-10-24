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

  /// Uses a switch for every if condition that projects or tests a SwiftSyntax node type.
  /// Recognizes a concrete syntax metatype argument, including calls through wrapper methods.
  /// Reports each if once. Does not rewrite or combine branches.
  func checkSyntaxDispatch(_ conditional: IfExprSyntax) {
    checkDispatch(conditional, rule: .preferSyntaxKindSwitch, match: syntaxDispatch)
  }

  /// Uses a switch for every if condition that contains a native as? or is check.
  /// Checks extra conditions, negation and receivers with calls or properties. Keeps evaluation order.
  func checkTypeDispatch(_ conditional: IfExprSyntax) {
    checkDispatch(conditional, rule: .preferTypeSwitch, match: typeDispatch)
  }

  private func checkDispatch(
    _ conditional: IfExprSyntax,
    rule: StyleRule,
    match: (Syntax) -> Bool
  ) {
    if conditional.conditions.contains(where: { containsTypeCheck(Syntax($0), match: match) }) {
      report(rule, conditional.ifKeyword)
    }
  }

  /// Leaves nested closures and branch bodies to their own visitors.
  private func containsTypeCheck(_ node: Syntax, match: (Syntax) -> Bool) -> Bool {
    switch node.as(SyntaxEnum.self) {
    case .closureExpr, .ifExpr, .switchExpr: return false
    default: break
    }

    if match(node) { return true }

    return node.children(viewMode: .sourceAccurate).contains { containsTypeCheck($0, match: match) }
  }

  private func syntaxDispatch(_ node: Syntax) -> Bool {
    guard let call = node.as(FunctionCallExprSyntax.self),
          call.arguments.count == 1,
          call.arguments.first?.label == nil,
          call.trailingClosure == nil,
          call.additionalTrailingClosures.isEmpty,
          call.calledExpression.is(MemberAccessExprSyntax.self),
          let argument = call.arguments.first?.expression.as(MemberAccessExprSyntax.self),
          argument.declName.baseName.text == "self"
    else { return false }

    let type: String? = switch argument.base?.as(ExprSyntaxEnum.self) {
    case .declReferenceExpr(let reference)?: reference.baseName.text
    case .memberAccessExpr(let member)?: member.declName.baseName.text
    default: nil
    }

    return type?.hasSuffix("Syntax") == true
  }

  private func typeDispatch(_ node: Syntax) -> Bool {
    switch node.as(SyntaxEnum.self) {
    case .isExpr: true

    case .asExpr(let cast):
      cast.questionOrExclamationMark?.tokenKind == .postfixQuestionMark

    default: false
    }
  }
}
