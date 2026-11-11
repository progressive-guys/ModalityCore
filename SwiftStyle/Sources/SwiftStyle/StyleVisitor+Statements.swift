import SwiftSyntax

extension StyleVisitor {

  private enum StatementGroup {

    case declaration
    case check
    case assertion
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
  /// Configuring a local receiver keeps its group when arguments come from earlier groups.
  /// Structural boundaries and combined preparation groups require separation.
  /// Direct assertions stay beside the declaration or assignment they check.
  /// Other assertions and checks after actions start a group. Assertion groups keep manual separators.
  /// Calls on one local receiver stay together across changes of method.
  /// Ordinary actions and related multiline pairs allow one manual separator.
  /// Adjacent multiline assignments require one blank line, including direct dependencies.
  /// Consecutive single-line assignments stay together, at any group length.
  /// An owner change separates an assignment run that continues with calls on its new owner.
  /// Two calls followed by two assignments require a separator, including operations on the same owner.
  /// Two declarations followed by two single-line assignments separate preparation from writes.
  /// Multiline guards and non-call declarations require one blank line before the next statement.
  /// Local calls with more than three argument code lines require a separator.
  /// Shorter wrapped calls keep zero or one blank line.
  /// Other bodies with at most three code lines stay compact. Leading group comments keep separation.
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
    var derivedDeclaration = false

    var configuredReference = layout.isSingleLineGroupElement(first) ? nil : previousDependencies.mutatedReference
    let series = statements.map { statementSeries($0) }
    let singleLineStatements = statements.map { layout.isSingleLineGroupElement($0) }
    let items = Array(statements)
    let dependenciesByStatement = items.map { StatementDependencies($0) }
    var followedByOwnerCall = Array(repeating: false, count: items.count)
    for index in items.indices.dropLast().reversed() {
      let current = dependenciesByStatement[index]
      let next = dependenciesByStatement[index + 1]
      if let owner = current.actionReceiver, owner == next.actionReceiver,
         !layout.hasGroupHeader(items[index + 1])
      {
        followedByOwnerCall[index] = next.calledReceiver != nil || followedByOwnerCall[index + 1]
      }
    }

    for (index, pair) in zip(statements, statements.dropFirst()).enumerated() {
      let (previous, current) = pair
      let dependencies = dependenciesByStatement[index + 1]
      let currentGroup = statementGroup(current)
      let checkReferences = currentGroup == .assertion
        ? dependencies.immediateReferences
        : dependencies.conditionReferences

      let checksMutation = previousDependencies.mutatedReference.map {
        checkReferences.contains($0)
      } ?? false

      let uses = dependencies.references.intersection(knownNames)
      let previousGroup = statementGroup(previous)
      let checksDeclaration = previousGroup == .declaration
        && !previousDependencies.declarations.isDisjoint(with: checkReferences)

      let returnsDeclaration = previousGroup == .declaration
        && current.item.is(ReturnStmtSyntax.self)
        && !previousDependencies.declarations.isDisjoint(with: dependencies.immediateReferences)
        && dependencies.immediateReferences.intersection(knownNames).isSubset(of: groupNames)

      let usesMutation = currentGroup.isAction
        && (previousDependencies.mutatedReference.map { dependencies.references.contains($0) } ?? false)

      let usesConfiguration = currentGroup.isAction
        && (configuredReference.map { dependencies.references.contains($0) } ?? false)

      let related = !uses.isDisjoint(with: groupNames) || usesConfiguration
      let configuresLocal = dependencies.actionReceiver.map { groupNames.contains($0) } ?? false
      let combined = related && !configuresLocal && !uses.isSubset(of: groupNames)
      let declarations = declarationsOnly
        && !derivedDeclaration
        && currentGroup == .declaration
        && layout.isSingleLineGroupElement(previous)
        && layout.isSingleLineGroupElement(current)

      let ordinaryActions = previousGroup.isAction && currentGroup.isAction
      let sameLocalReceiver = dependencies.calledReceiver.map { receiver in
        receiver == previousDependencies.calledReceiver
          && receiver.split(separator: ".").first.map { groupNames.contains(String($0)) } == true
      } ?? false

      let assignmentPair = previousGroup == .assignment
        && currentGroup == .assignment
        && layout.isSingleLineGroupElement(previous)
        && layout.isSingleLineGroupElement(current)

      let configurationPair = ordinaryActions && (previousGroup == .assignment || currentGroup == .assignment)
      let sameOwner = configurationPair
        && dependencies.actionReceiver != nil
        && dependencies.actionReceiver == previousDependencies.actionReceiver

      let changesOwner = configurationPair
        && dependencies.actionReceiver != nil
        && previousDependencies.actionReceiver != nil
        && !sameOwner

      let multilinePair = !layout.isSingleLineGroupElement(previous) && !layout.isSingleLineGroupElement(current)
      let header = layout.hasGroupHeader(current)
      let boundary = current.item.is(IfConfigDeclSyntax.self) || previous.item.is(IfConfigDeclSyntax.self)
      let assertionBoundary = (previousGroup == .assertion) != (currentGroup == .assertion)
      let checkAfterAction = previousGroup.isAction && currentGroup == .check
      let completedConfiguration = configuredReference != nil
        && previousGroup.isAction
        && currentGroup != .assignment
        && !related

      let endsSeries = index > 0 && series[index] != nil && series[index - 1] == series[index]

      let beginsSeries = index + 2 < series.count
        && series[index + 1] != nil
        && series[index + 1] == series[index + 2]

      let callAssignmentSeries = index > 0
        && currentGroup == .assignment
        && beginsSeries
        && singleLineStatements[index + 1]
        && singleLineStatements[index + 2]
        && series[index] != nil
        && series[index] != "="
        && series[index - 1] != nil
        && series[index - 1] != "="

      let declarationAssignmentSeries = index > 0
        && previousGroup == .declaration
        && statementGroup(items[index - 1]) == .declaration
        && currentGroup == .assignment
        && beginsSeries
        && singleLineStatements[index + 1]
        && singleLineStatements[index + 2]

      let seriesBoundary = previousGroup.isAction
        && currentGroup.isAction
        && !sameLocalReceiver
        && series[index] != series[index + 1]
        && (endsSeries || beginsSeries)

      let spacing = layout.groupSpacing(between: previous, and: current)

      let manualPreparationBoundary = declarations
        && !related
        && spacing?.blankLines.isEmpty == false
        && !previousDependencies.references.isDisjoint(with: groupNames)

      let startsGroup = header
        || boundary
        || combined
        || assertionBoundary
        || checkAfterAction
        || completedConfiguration
        || seriesBoundary
        || manualPreparationBoundary
        || (!ordinaryActions && !declarations && !related && (!groupNames.isEmpty || !uses.isEmpty))

      if let spacing,
         let token = current.firstToken(viewMode: .sourceAccurate)
      {
        let multilineGuard = previous.item.is(GuardStmtSyntax.self)
          && layout.line(previous) != layout.endLine(previous)

        let argumentLines = wrappedCallArgumentLineCount(previous)
        let largeCallDeclaration = argumentLines.map { $0 > 3 } ?? false
        let rule: StyleRule = argumentLines != nil && !header ? .multilineCallDeclarationSpacing : .statementGrouping
        let multilineDeclaration = previousGroup == .declaration
          && layout.line(previous) != layout.endLine(previous)
          && argumentLines == nil

        let multilineAssignments = previousGroup == .assignment && currentGroup == .assignment && multilinePair

        let allowedBlankLines = if header
          || multilineGuard
          || multilineDeclaration
          || largeCallDeclaration
          || multilineAssignments {
          1...1
        } else if compactScope {
          0...0
        } else if assignmentPair && !(changesOwner && followedByOwnerCall[index + 1]) {
          0...0
        } else if changesOwner || callAssignmentSeries || declarationAssignmentSeries {
          1...1
        } else if sameOwner {
          layout.isSingleLineGroupElement(previous) && layout.isSingleLineGroupElement(current) ? 0...0 : 0...1
        } else if previousGroup == .assertion && currentGroup == .assertion {
          0...1
        } else if checksMutation || checksDeclaration || returnsDeclaration {
          multilinePair ? 0...1 : 0...0
        } else if (usesMutation || usesConfiguration) && !combined {
          0...0
        } else if ordinaryActions && sameLocalReceiver && !combined {
          multilinePair ? 0...1 : 0...0
        } else if startsGroup {
          1...1
        } else if ordinaryActions || (related && multilinePair) {
          0...1
        } else if related
          && previousGroup == .action
          && currentGroup == .declaration
          && singleLineStatements[index]
          && singleLineStatements[index + 1]
          && previousDependencies.sharesCallArgument(with: dependencies, in: groupNames)
        {
          0...1
        } else if related || declarations {
          0...0
        } else if previousGroup.spacingGroup != currentGroup.spacingGroup {
          1...1
        } else {
          spacing.required...spacing.required
        }

        let maximumBlankLines = argumentLines == nil ? allowedBlankLines.upperBound : 1
        let permittedBlankLines = allowedBlankLines.lowerBound...maximumBlankLines
        if permittedBlankLines.contains(0) {
          compactStatementStarts.insert(token.positionAfterSkippingLeadingTrivia.utf8Offset)
        }

        if !permittedBlankLines.contains(spacing.blankLines.count) {
          fixSpacing(spacing.blankLines, required: permittedBlankLines.upperBound, rule: rule)
          report(rule, token)
        }
      }

      if startsGroup || (!related && !declarations) {
        groupNames = uses
        declarationsOnly = currentGroup == .declaration
        derivedDeclaration = false
        configuredReference = nil
      } else {
        declarationsOnly = declarationsOnly && currentGroup == .declaration
      }

      groupNames.formUnion(dependencies.declarations)

      if previousGroup == .declaration, currentGroup == .declaration,
         !previousDependencies.declarations.isDisjoint(with: dependencies.references)
      { derivedDeclaration = true }

      if currentGroup == .assignment, !layout.isSingleLineGroupElement(current) {
        configuredReference = dependencies.mutatedReference
      }
      knownNames.formUnion(dependencies.declarations)
      previousDependencies = dependencies
    }
  }

  /// Finds the largest wrapped argument block in a local declaration.
  private func wrappedCallArgumentLineCount(_ statement: CodeBlockItemSyntax) -> Int? {
    guard case .decl(let declaration) = statement.item,
          let variable = declaration.as(VariableDeclSyntax.self)
    else { return nil }

    let counts = variable.bindings.compactMap { binding in
      binding.initializer.flatMap { wrappedCallArgumentLineCount($0.value) }
    }

    return counts.max()
  }

  /// Counts argument code lines without the call's outer parentheses, blank lines or comments.
  private func wrappedCallArgumentLineCount(_ expression: ExprSyntax) -> Int? {
    switch expression.as(ExprSyntaxEnum.self) {
    case .tryExpr(let attempt): return wrappedCallArgumentLineCount(attempt.expression)
    case .awaitExpr(let awaited): return wrappedCallArgumentLineCount(awaited.expression)
    case .functionCallExpr(let call):
      guard call.trailingClosure == nil, let opening = call.leftParen, let closing = call.rightParen,
            layout.line(opening) < layout.line(closing)
      else { return nil }

      return layout.codeLineCount(call.arguments)

    default: return nil
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
    case .tryExpr(let expression): expressionGroup(expression.expression)
    case .awaitExpr(let expression): expressionGroup(expression.expression)
    case .macroExpansionExpr(let expansion) where expansion.macroName.text == "expect": .assertion
    case .functionCallExpr(let call) where isAssertion(call.calledExpression): .assertion
    case .ifExpr: .check
    case .switchExpr: .statement
    case .infixOperatorExpr(let operation) where operation.operator.is(AssignmentExprSyntax.self): .assignment
    default: .action
    }
  }

  /// Test assertions start a verification group. require macros still produce input values.
  private func isAssertion(_ expression: ExprSyntax) -> Bool {
    switch expression.as(ExprSyntaxEnum.self) {
    case .declReferenceExpr(let reference): reference.baseName.text.hasPrefix("XCTAssert")
    case .memberAccessExpr(let member): member.declName.baseName.text.hasPrefix("XCTAssert")
    default: false
    }
  }

  /// Repeated method calls and assignments form a series. Keep the full receiver path.
  private func statementSeries(_ item: CodeBlockItemSyntax) -> String? {
    switch item.item {
    case .expr(let expression): expressionSeries(expression)
    case .stmt(let statement):
      statement.as(ExpressionStmtSyntax.self).flatMap { expressionSeries($0.expression) }
    default: nil
    }
  }

  private func expressionSeries(_ expression: ExprSyntax) -> String? {
    switch expression.as(ExprSyntaxEnum.self) {
    case .tryExpr(let expression): expressionSeries(expression.expression)
    case .awaitExpr(let expression): expressionSeries(expression.expression)
    case .infixOperatorExpr(let operation) where operation.operator.is(AssignmentExprSyntax.self): "="
    case .functionCallExpr(let call):
      SourceLayout.compact(call.calledExpression.trimmedDescription)
    default: nil
    }
  }
}
