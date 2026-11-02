import SwiftSyntax

extension StyleVisitor {

  private enum StatementGroup {

    case declaration
    case check
    case exit
    case statement
  }

  /// Separates local declarations, checks, exits and other statements with one blank line.
  /// Adjacent compact checks stay together. Multiline checks use one blank line.
  /// Leading comments start a group. Local declaration types do not create group boundaries.
  /// Bodies with at most three code lines keep statements together.
  /// In a scope of at most four code lines, a binding stays beside a check that reads its value.
  /// Checks spacing only. Preserves statement order and all expressions.
  func checkStatementGrouping(_ statements: CodeBlockItemListSyntax) {
    guard statements.ancestorIs(CodeBlockSyntax.self)
      || statements.ancestorIs(ClosureExprSyntax.self)
      || statements.ancestorIs(AccessorBlockSyntax.self)
    else { return }

    let codeLines = Set(statements.tokens(viewMode: .sourceAccurate).flatMap { layout.line($0)...layout.endLine($0) })
    let compactScope = codeLines.count <= 4

    for (previous, current) in zip(statements, statements.dropFirst()) {
      guard let spacing = layout.groupSpacing(between: previous, and: current),
            let token = current.firstToken(viewMode: .sourceAccurate)
      else { continue }

      let previousGroup = statementGroup(previous)
      let currentGroup = statementGroup(current)
      let configuration = configuresNewLocal(previous, current)
      let localCheck = compactScope && checksNewLocal(previous, current)

      let allowedBlankLines = if layout.hasGroupHeader(current) {
        1...1
      } else if codeLines.count <= 3 {
        0...0
      } else if configuration || localCheck {
        0...0
      } else if previousGroup != currentGroup {
        1...1
      } else {
        spacing.required...spacing.required
      }

      if !allowedBlankLines.contains(spacing.blankLines.count) {
        fixSpacing(spacing.blankLines, required: allowedBlankLines.lowerBound, rule: .statementGrouping)
        report(.statementGrouping, token)
      }
    }
  }

  /// Reads conditions only. A reference in the body does not connect a check to a binding.
  private func checksNewLocal(_ previous: CodeBlockItemSyntax, _ current: CodeBlockItemSyntax) -> Bool {
    guard let name = newLocalName(previous) else { return false }

    let conditions: ConditionElementListSyntax? = switch current.item {
    case .expr(let expression): expression.as(IfExprSyntax.self)?.conditions
    case .stmt(let statement):
      switch statement.as(StmtSyntaxEnum.self) {
      case .guardStmt(let statement): statement.conditions
      case .expressionStmt(let statement): statement.expression.as(IfExprSyntax.self)?.conditions
      default: nil
      }

    default: nil
    }

    guard let conditions else { return false }

    for condition in conditions {
      switch condition.condition {
      case .optionalBinding(let binding):
        let shadowsLocal = binding.pattern.tokens(viewMode: .sourceAccurate).contains { $0.text == name }

        if let initializer = binding.initializer {
          if referencesLocal(initializer.value, named: name) { return true }
        } else if shadowsLocal {
          return true
        }

        // A new binding shadows the previous local in the remaining conditions.
        if shadowsLocal { return false }

      case .matchingPattern(let binding):
        if referencesLocal(binding.initializer.value, named: name) { return true }
        if binding.pattern.tokens(viewMode: .sourceAccurate).contains(where: { $0.text == name }) { return false }

      case .expression(let expression):
        if referencesLocal(expression, named: name) { return true }

      default: break
      }
    }

    return false
  }

  private func newLocalName(_ item: CodeBlockItemSyntax) -> String? {
    guard let declaration = item.item.as(VariableDeclSyntax.self), declaration.bindings.count == 1,
          let binding = declaration.bindings.first, binding.initializer != nil,
          let pattern = binding.pattern.as(IdentifierPatternSyntax.self)
    else { return nil }

    return pattern.identifier.text
  }

  /// Keeps a fresh local binding beside its immediate single-line use or configuration.
  private func configuresNewLocal(_ previous: CodeBlockItemSyntax, _ current: CodeBlockItemSyntax) -> Bool {
    guard layout.isSingleLineGroupElement(previous), layout.isSingleLineGroupElement(current),
          let name = newLocalName(previous)
    else { return false }

    let expression: ExprSyntax? = switch current.item {
    case .expr(let expression): expression
    case .stmt(let statement):
      switch statement.as(StmtSyntaxEnum.self) {
      case .expressionStmt(let statement): statement.expression
      default: nil
      }

    default: nil
    }

    guard let expression else { return false }

    switch expression.as(ExprSyntaxEnum.self) {
    case .infixOperatorExpr(let assignment):
      switch assignment.operator.as(ExprSyntaxEnum.self) {
      case .assignmentExpr:
        switch assignment.leftOperand.as(ExprSyntaxEnum.self) {
        case .memberAccessExpr, .subscriptCallExpr:
          return configurationRoot(assignment.leftOperand) == name
            || referencesLocal(assignment.rightOperand, named: name)

        default: return false
        }

      default: return false
      }

    case .functionCallExpr(let call):
      return referencesLocal(call.calledExpression, named: name)
        || call.arguments.contains { referencesLocal($0.expression, named: name) }

    default: return false
    }
  }

  private func configurationRoot(_ expression: ExprSyntax) -> String? {
    switch expression.as(ExprSyntaxEnum.self) {
    case .declReferenceExpr(let reference): reference.baseName.text
    case .memberAccessExpr(let member): member.base.flatMap(configurationRoot)
    case .subscriptCallExpr(let call): configurationRoot(call.calledExpression)
    case .optionalChainingExpr(let optional): configurationRoot(optional.expression)
    default: nil
    }
  }

  private func referencesLocal(_ expression: ExprSyntax, named name: String) -> Bool {
    let visitor = LocalUseVisitor(name: name)
    visitor.walk(expression)
    return visitor.found
  }

  private func statementGroup(_ item: CodeBlockItemSyntax) -> StatementGroup {
    switch item.item {
    case .decl(let declaration) where declaration.is(VariableDeclSyntax.self): .declaration
    case .expr(let expression) where expression.is(IfExprSyntax.self): .check

    case .stmt(let statement):
      switch statement.as(StmtSyntaxEnum.self) {
      case .guardStmt: .check
      case .expressionStmt(let statement) where statement.expression.is(IfExprSyntax.self): .check
      case .returnStmt, .throwStmt, .breakStmt, .continueStmt: .exit
      default: .statement
      }

    default: .statement
    }
  }
}

/// Finds an immediate reference. Closure bodies can defer evaluation or introduce a shadowing name.
private final class LocalUseVisitor: SyntaxVisitor {

  let name: String

  var found = false

  init(name: String) {
    self.name = name
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: DeclReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    switch (Syntax(node.parent)?.as(SyntaxEnum.self)) {
    case .memberAccessExpr(let member)? where (member.declName.id == node.id):
      return .skipChildren
    default:
      break
    }

    if node.baseName.text == name { found = true }

    return .skipChildren
  }

  override func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind { .skipChildren }
}
