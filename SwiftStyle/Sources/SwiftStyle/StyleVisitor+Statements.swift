import SwiftSyntax

extension StyleVisitor {
  /// Separates local declarations, checks, exits and other statements with one blank line.
  /// Adjacent compact checks stay together. Multiline checks permit zero or one blank line.
  /// Leading comments start a group. Local declarations of different types remain separate groups.
  /// Checks spacing only. Preserves statement order and all expressions.
  func checkStatementGrouping(_ statements: CodeBlockItemListSyntax) {
    guard statements.ancestorIs(CodeBlockSyntax.self)
      || statements.ancestorIs(ClosureExprSyntax.self)
      || statements.ancestorIs(AccessorBlockSyntax.self)
    else { return }

    for (previous, current) in zip(statements, statements.dropFirst()) {
      guard let spacing = layout.groupSpacing(between: previous, and: current),
            let token = current.firstToken(viewMode: .sourceAccurate)
      else { continue }

      let previousGroup = statementGroup(previous)
      let currentGroup = statementGroup(current)
      let differentDataGroup = localDataGroupsDiffer(previous, current)

      let allowedBlankLines = if previousGroup != currentGroup || differentDataGroup || layout.hasGroupHeader(current) {
        1...1
      } else if currentGroup == .check {
        0...spacing.required
      } else {
        spacing.required...spacing.required
      }

      if !allowedBlankLines.contains(spacing.blankLines.count) { report(.statementGrouping, token) }
    }
  }

  private func localDataGroupsDiffer(_ previous: CodeBlockItemSyntax, _ current: CodeBlockItemSyntax) -> Bool {
    guard let left = previous.item.as(VariableDeclSyntax.self),
          let right = current.item.as(VariableDeclSyntax.self)
    else { return false }

    let previous = PropertyLayout(left)
    let current = PropertyLayout(right)

    return previous.kind != current.kind || previous.annotations != current.annotations
      || previous.type != nil && current.type != nil && previous.type != current.type
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

  private enum StatementGroup {
    case declaration
    case check
    case exit
    case statement
  }
}
