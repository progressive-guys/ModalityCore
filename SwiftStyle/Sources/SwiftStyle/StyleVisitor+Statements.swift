import SwiftSyntax

extension StyleVisitor {

  private enum StatementGroup {

    case declaration
    case check
    case exit
    case action
    case assignment
    case statement

    var isAction: Bool { self == .action || self == .assignment }

    /// Uses the established statement layout outside the optional action separator.
    var spacingGroup: Self { isAction ? .statement : self }
  }

  /// Removes opening blank lines from executable bodies. Closure parameters stay before the body.
  /// Type bodies use member_spacing. Comments keep their positions.
  func checkScopeOpening(_ node: Syntax, brace: TokenSyntax) {
    let contents: Syntax
    let opening: TokenSyntax
    let closing: TokenSyntax

    switch node.as(SyntaxEnum.self) {
    case .codeBlock(let block):
      contents = Syntax(block.statements)
      opening = brace
      closing = block.rightBrace

    case .closureExpr(let closure):
      contents = Syntax(closure.statements)
      opening = closure.signature?.inKeyword ?? brace
      closing = closure.rightBrace

    case .accessorBlock(let block):
      contents = Syntax(block.accessors)
      opening = brace
      closing = block.rightBrace

    case .switchExpr(let expression):
      contents = Syntax(expression.cases)
      opening = brace
      closing = expression.rightBrace

    case .memberBlock(let block) where block.members.isEmpty:
      contents = Syntax(block.members)
      opening = brace
      closing = block.rightBrace

    default: return
    }

    let first = contents.firstToken(viewMode: .sourceAccurate) == nil ? Syntax(closing) : contents
    let rule: StyleRule = node.is(MemberBlockSyntax.self) ? .memberSpacing : .statementGrouping

    guard let spacing = layout.groupSpacing(between: opening, and: first),
          !spacing.blankLines.isEmpty
    else { return }

    fixSpacing(spacing.blankLines, required: 0, rule: rule)

    report(
      rule,
      opening,
      reason: "Remove the opening blank line from an executable body."
    )
  }

  /// Groups consecutive uses of local values, including branches and closure captures.
  /// Immediate declarations and mutations stay beside checks that read their values.
  /// Structural boundaries and combined preparation groups require separation.
  /// Ordinary actions and related multiline pairs allow one manual separator.
  /// Consecutive single-line assignments stay together, at any group length.
  /// Bodies with at most three code lines stay compact. Leading group comments keep separation.
  func checkStatementGrouping(_ statements: CodeBlockItemListSyntax) {
    guard statements.ancestorIs(CodeBlockSyntax.self)
      || statements.ancestorIs(ClosureExprSyntax.self)
      || statements.ancestorIs(AccessorBlockSyntax.self),
      let first = statements.first
    else { return }

    let compactScope = layout.codeLineCount(statements) <= 3
    var previousDependencies = StatementDependencies(first)
    var knownNames = previousDependencies.declarations
    var groupNames = knownNames
    var declarationsOnly = statementGroup(first) == .declaration
    for (previous, current) in zip(statements, statements.dropFirst()) {
      let dependencies = StatementDependencies(current)
      let checksMutation = previousDependencies.mutatedReference.map {
        dependencies.conditionReferences.contains($0)
      } ?? false
      let uses = dependencies.references.intersection(knownNames)
      let previousGroup = statementGroup(previous)
      let currentGroup = statementGroup(current)
      let checksDeclaration = previousGroup == .declaration
        && !previousDependencies.declarations.isDisjoint(with: dependencies.conditionReferences)
      let related = !uses.isDisjoint(with: groupNames)
      let combined = related && !uses.isSubset(of: groupNames)
      let declarations = declarationsOnly && currentGroup == .declaration
        && layout.isSingleLineGroupElement(previous) && layout.isSingleLineGroupElement(current)
      let ordinaryActions = previousGroup.isAction && currentGroup.isAction
      let assignmentPair = previousGroup == .assignment && currentGroup == .assignment
        && layout.isSingleLineGroupElement(previous) && layout.isSingleLineGroupElement(current)

      let multilinePair = !layout.isSingleLineGroupElement(previous) && !layout.isSingleLineGroupElement(current)
      let header = layout.hasGroupHeader(current)
      let boundary = current.item.is(IfConfigDeclSyntax.self) || previous.item.is(IfConfigDeclSyntax.self)

      let startsGroup = header || boundary || combined
        || (!ordinaryActions && !declarations && !related && (!groupNames.isEmpty || !uses.isEmpty))

      if let spacing = layout.groupSpacing(between: previous, and: current),
         let token = current.firstToken(viewMode: .sourceAccurate)
      {
        let allowedBlankLines = if header {
          1...1
        } else if compactScope || assignmentPair {
          0...0
        } else if checksMutation || checksDeclaration {
          multilinePair ? 0...1 : 0...0
        } else if startsGroup {
          1...1
        } else if ordinaryActions || (related && multilinePair) {
          0...1
        } else if related || declarations {
          0...0
        } else if previousGroup.spacingGroup != currentGroup.spacingGroup {
          1...1
        } else {
          spacing.required...spacing.required
        }
        if allowedBlankLines.contains(0) {
          compactStatementStarts.insert(token.positionAfterSkippingLeadingTrivia.utf8Offset)
        }
        if !allowedBlankLines.contains(spacing.blankLines.count) {
          fixSpacing(spacing.blankLines, required: allowedBlankLines.upperBound, rule: .statementGrouping)
          report(.statementGrouping, token)
        }
      }

      if startsGroup || (!related && !declarations) {
        groupNames = uses
        declarationsOnly = currentGroup == .declaration
      } else {
        declarationsOnly = declarationsOnly && currentGroup == .declaration
      }

      groupNames.formUnion(dependencies.declarations)
      knownNames.formUnion(dependencies.declarations)
      previousDependencies = dependencies
    }
  }

  private func statementGroup(_ item: CodeBlockItemSyntax) -> StatementGroup {
    switch item.item {
    case .decl(let declaration) where declaration.is(VariableDeclSyntax.self): .declaration
    case .expr(let expression): expressionGroup(expression)

    case .stmt(let statement):
      switch statement.as(StmtSyntaxEnum.self) {
      case .guardStmt: .check
      case .expressionStmt(let statement): expressionGroup(statement.expression)
      case .returnStmt, .throwStmt, .breakStmt, .continueStmt: .exit
      default: .statement
      }

    default: .statement
    }
  }

  private func expressionGroup(_ expression: ExprSyntax) -> StatementGroup {
    switch expression.as(ExprSyntaxEnum.self) {
    case .ifExpr: .check
    case .switchExpr: .statement
    case .infixOperatorExpr(let operation) where operation.operator.is(AssignmentExprSyntax.self): .assignment
    default: .action
    }
  }
}
