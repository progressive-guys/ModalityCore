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
        fixSpacing(spacing.blankLines, required: spacing.required, rule: .switchCaseSpacing)
        report(.switchCaseSpacing, token)
      }
    }

    for element in cases {
      guard let configuration = element.as(IfConfigDeclSyntax.self) else { continue }
      for clause in configuration.clauses {
        switch (Syntax(clause.elements)?.as(SyntaxEnum.self)) {
        case .switchCaseList(let branch)?:
          checkSwitchCaseSpacing(branch)
        default:
          break
        }
      }
    }
  }

  /// Requires a switch for consecutive SwiftSyntax type checks of the same object.
  func checkSyntaxDispatch(_ conditional: IfExprSyntax) {
    if TypeCheckSequence.contains(conditional, rule: .preferSyntaxKindSwitch) {
      report(.preferSyntaxKindSwitch, conditional.ifKeyword)
    }
  }

  /// Requires a switch for consecutive native type checks of the same object.
  func checkTypeDispatch(_ conditional: IfExprSyntax) {
    if TypeCheckSequence.contains(conditional, rule: .preferTypeSwitch) {
      report(.preferTypeSwitch, conditional.ifKeyword)
    }
  }
}

/// Matches adjacent checks without treating repeated calls as the same object.
enum TypeCheckSequence {

  static func contains(_ conditional: IfExprSyntax, rule: StyleRule, subject: String? = nil) -> Bool {
    let receivers = subjects(in: Syntax(conditional.conditions), rule: rule)
    guard !receivers.isEmpty else { return false }
    if zip(receivers, receivers.dropFirst()).contains(where: { $0 == $1 && (subject == nil || $0 == subject) }) {
      return true
    }

    var neighbors: [(conditional: IfExprSyntax, follows: Bool)] = []
    if case .ifExpr(let next)? = conditional.elseBody { neighbors.append((next, true)) }

    var node = Syntax(conditional)
    if case .ifExpr(let parent)? = node.parent?.as(SyntaxEnum.self) {
      neighbors.append((parent, false))
    }
    if case .expressionStmt? = node.parent?.as(SyntaxEnum.self), let parent = node.parent {
      node = parent
    }
    if let item = node.parent?.as(CodeBlockItemSyntax.self),
       let items = item.parent?.as(CodeBlockItemListSyntax.self)
    {
      let siblings = Array(items)
      if let index = siblings.firstIndex(where: { $0.id == item.id }) {
        if index > 0, let previous = Self.conditional(in: siblings[index - 1]) { neighbors.append((previous, false)) }

        if index + 1 < siblings.count, let next = Self.conditional(in: siblings[index + 1]) {
          neighbors.append((next, true))
        }
      }
    }

    return neighbors.contains { neighbor in
      let other = subjects(in: Syntax(neighbor.conditional.conditions), rule: rule)
      let left = neighbor.follows ? receivers.last : other.last
      let right = neighbor.follows ? other.first : receivers.first
      return left != nil && left == right && (subject == nil || left == subject)
    }
  }

  /// Limits each fix to the object that has repeated type checks.
  static func contains(_ expression: ExprSyntax, in conditional: IfExprSyntax, rule: StyleRule) -> Bool {
    subjects(in: Syntax(expression), rule: rule).contains { subject in
      contains(conditional, rule: rule, subject: subject)
    }
  }

  private static func conditional(in item: CodeBlockItemSyntax) -> IfExprSyntax? {
    switch Syntax(item.item).as(SyntaxEnum.self) {
    case .ifExpr(let conditional): conditional
    case .expressionStmt(let statement): statement.expression.as(IfExprSyntax.self)
    default: nil
    }
  }

  /// Keeps checks in nested closures and branch bodies in their own sequences.
  private static func subjects(in node: Syntax, rule: StyleRule) -> [String] {
    switch node.as(SyntaxEnum.self) {
    case .closureExpr, .ifExpr, .switchExpr: return []
    default: break
    }

    if let subject = subject(node, rule: rule) { return [subject] }

    return node.children(viewMode: .sourceAccurate).flatMap { subjects(in: $0, rule: rule) }
  }

  private static func subject(_ node: Syntax, rule: StyleRule) -> String? {
    let receiver: ExprSyntax

    switch (rule, node.as(SyntaxEnum.self)) {
    case (.preferSyntaxKindSwitch, .functionCallExpr(let call)):
      guard call.arguments.count == 1, call.arguments.first?.label == nil,
            call.trailingClosure == nil, call.additionalTrailingClosures.isEmpty,
            let member = call.calledExpression.as(MemberAccessExprSyntax.self),
            ["as", "is"].contains(member.declName.baseName.text), let base = member.base,
            let argument = call.arguments.first?.expression.as(MemberAccessExprSyntax.self),
            argument.declName.baseName.text == "self",
            let name = argument.base?.lastToken(viewMode: .sourceAccurate)?.text,
            SyntaxProjection.isConcrete(name)
      else { return nil }
      receiver = base

    case (.preferTypeSwitch, .isExpr(let test)):
      receiver = test.expression

    case (.preferTypeSwitch, .asExpr(let cast)) where cast.questionOrExclamationMark?.tokenKind == .postfixQuestionMark:
      receiver = cast.expression

    default: return nil
    }

    return object(receiver)
  }

  private static func object(_ expression: ExprSyntax) -> String? {
    switch expression.as(ExprSyntaxEnum.self) {
    case .declReferenceExpr(let reference): reference.trimmedDescription
    case .memberAccessExpr(let member):
      member.base.flatMap(object).map { $0 + "." + member.declName.baseName.text }
    case .optionalChainingExpr(let optional): object(optional.expression).map { $0 + "?" }
    case .tupleExpr(let tuple) where tuple.elements.count == 1:
      tuple.elements.first.flatMap { object($0.expression) }
    default: nil
    }
  }
}
