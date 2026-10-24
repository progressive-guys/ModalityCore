import SwiftSyntax

final class StyleVisitor: SyntaxVisitor {
  let file: String
  let layout: SourceLayout
  private(set) var diagnostics: [LintDiagnostic] = []

  init(file: String, source: String, tree: SourceFileSyntax) {
    self.file = file
    layout = SourceLayout(source: source, file: file, tree: tree)
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: IfExprSyntax) -> SyntaxVisitorContinueKind {
    checkConditions(node)
    if node.elseBody == nil,
       node.body.statements.count == 1,
       let statement = node.body.statements.first?.item.as(ExpressionStmtSyntax.self),
       let nested = statement.expression.as(IfExprSyntax.self),
       nested.elseBody == nil
    {
      report(.collapsibleNestedIf, node.ifKeyword)
    }
    checkSingleLineBody(node.body, rule: .singleLineIfExit, at: node.ifKeyword)
    if let body = node.elseBody?.as(CodeBlockSyntax.self), let keyword = node.elseKeyword {
      checkElse(body, keyword: keyword)
    }
    return .visitChildren
  }

  override func visit(_ node: SwitchExprSyntax) -> SyntaxVisitorContinueKind {
    checkSwitchCaseSpacing(node.cases)
    return .visitChildren
  }

  override func visit(_ node: CodeBlockItemListSyntax) -> SyntaxVisitorContinueKind {
    checkSyntaxDispatch(node)
    return .visitChildren
  }

  override func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    checkElse(node.body, keyword: node.elseKeyword)
    let header = "guard " + layout.compact(node.conditions.trimmedDescription)
    let starts = node.conditions.map { layout.line($0) }
    if layout.indent(node) + header.count > 120,
       !layout.hasComments(node.conditions),
       starts.first == layout.line(node.guardKeyword) || Set(starts).count != starts.count
    {
      report(.multilineGuardConditions, node.guardKeyword)
    }
    if let statement = simpleExit(node.body),
       layout.line(node.body.leftBrace) != layout.endLine(node.body.rightBrace),
       layout.line(statement) == layout.endLine(statement),
       !layout.hasComments(node.body),
       layout.indent(node.elseKeyword) + "else { \(statement.trimmedDescription) }".count <= 120
    {
      report(.compactGuardExit, node.elseKeyword)
    }
    return .visitChildren
  }

  override func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
    if layout.line(node.equal) != layout.line(node.value) {
      report(.assignmentRhsSameLine, node.equal)
    }
    if let conditional = node.value.as(IfExprSyntax.self),
       let declaration = node.parent?.parent?.parent?.as(VariableDeclSyntax.self)
    {
      let keyword = declaration.bindingSpecifier
      if layout.line(keyword) != layout.line(conditional.ifKeyword) {
        report(.ifExpressionBindingSameLine, keyword)
      }
      let segments = layout.headerSegments(Syntax(conditional.conditions))
      let continued = segments.filter { layout.line($0) > layout.line(conditional.ifKeyword) }
      let hasInvalidIndent = continued.contains { segment in
        guard let token = segment.firstToken(viewMode: .sourceAccurate), layout.startsLine(token) else { return false }

        return layout.indent(token) != layout.indent(keyword) + 2
      }
      if hasInvalidIndent {
        report(.ifExpressionConditionIndent, conditional.ifKeyword)
      }
    }
    return .visitChildren
  }

  override func visit(_ node: InfixOperatorExprSyntax) -> SyntaxVisitorContinueKind {
    checkBinary(node)
    return .visitChildren
  }

  override func visit(_ node: MemberAccessExprSyntax) -> SyntaxVisitorContinueKind {
    checkMember(node)
    return .visitChildren
  }

  override func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    checkChainedCall(node)
    return .visitChildren
  }

  override func visit(_ node: ReturnClauseSyntax) -> SyntaxVisitorContinueKind {
    if let previous = node.arrow.previousToken(viewMode: .sourceAccurate),
       layout.endLine(previous) != layout.line(node.arrow) || layout.line(node.arrow) != layout.line(node.type)
    {
      report(.returnArrowNewline, node.arrow)
    }
    if layout.line(node.type) != layout.endLine(node.type) {
      report(.multilineReturnType, node.arrow)
    }
    return .visitChildren
  }

  override func visit(_ node: MemberTypeSyntax) -> SyntaxVisitorContinueKind {
    if layout.endLine(node.baseType) != layout.line(node.period),
       node.ancestorIs(ReturnClauseSyntax.self)
    {
      report(.splitReturnTypeMember, node.period)
    }
    return .visitChildren
  }

  override func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind {
    if layout.endLine(node.expression) != layout.line(node.asKeyword) {
      report(.castOperatorNewline, node.asKeyword)
    }
    return .visitChildren
  }

  override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
    if node.name.text != "debugFatalError", isGlobal(node) {
      report(.noGlobalFunctions, node.funcKeyword)
    }
    return .visitChildren
  }

  override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
    if node.memberBlock.members.contains(where: {
      $0.decl.is(EnumCaseDeclSyntax.self) && layout.line($0) == layout.line(node.memberBlock.leftBrace)
    }) {
      report(.enumCaseNewline, node.memberBlock.leftBrace)
    }
    checkEnumCaseSpacing(node.memberBlock.members)
    return .visitChildren
  }

  override func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if node.openingPounds == nil,
       node.openingQuote.tokenKind == .multilineStringQuote,
       node.segments.contains(where: { $0.is(ExpressionSegmentSyntax.self) }),
       layout.endLine(node) - layout.line(node) == 2,
       !node.trimmedDescription.contains("\\n"),
       !node.trimmedDescription.contains("\\r"),
       !node.trimmedDescription.contains("\\u{")
    {
      report(.singleLineInterpolatedString, node.openingQuote)
    }
    return .visitChildren
  }

  override func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {
    checkClosingDelimiter(token)
    if token.tokenKind == .leftBrace, let parent = token.parent {
      checkInlineBlock(parent, brace: token)
    }
    return .visitChildren
  }

  /// Reports each rule once per source line, including chains with multiple nested syntax nodes.
  func report(_ rule: StyleRule, _ token: TokenSyntax) {
    let location = layout.converter.location(for: token.positionAfterSkippingLeadingTrivia)
    guard !diagnostics.contains(where: { $0.ruleID == rule.rawValue && $0.line == location.line }) else { return }

    diagnostics.append(LintDiagnostic(
      file: file,
      line: location.line,
      character: location.column,
      ruleID: rule.rawValue,
      reason: rule.message
    ))
  }

  private func checkEnumCaseSpacing(_ members: MemberBlockItemListSyntax) {
    for (previous, current) in zip(members, members.dropFirst()) {
      guard previous.decl.is(EnumCaseDeclSyntax.self),
            let nextCase = current.decl.as(EnumCaseDeclSyntax.self)
      else { continue }

      if let spacing = layout.elementSpacing(between: previous, and: current),
         spacing.blankLines.count != spacing.required
      {
        report(.enumCaseBlankLine, nextCase.caseKeyword)
      }
    }
    for member in members {
      guard let configuration = member.decl.as(IfConfigDeclSyntax.self) else { continue }

      for clause in configuration.clauses {
        if let branch = clause.elements?.as(MemberBlockItemListSyntax.self) {
          checkEnumCaseSpacing(branch)
        }
      }
    }
  }

  private func checkConditions(_ node: IfExprSyntax) {
    let starts = node.conditions.map { layout.line($0) }
    let uniqueStarts = Set(starts)
    let nextConditions = node.conditions.dropFirst()
    let overlappingConditions = zip(node.conditions, nextConditions).contains { layout.endLine($0) >= layout.line($1) }
    if uniqueStarts.count > 1,
       uniqueStarts.count != starts.count || overlappingConditions
    {
      report(.mixedIfConditions, node.ifKeyword)
    }
    let externalBreak = layout.line(node.ifKeyword) != starts.first || layout.headerBreaks(node.conditions)
    let last = node.conditions.last
    if externalBreak, let last, layout.endLine(last) == layout.line(node.body.leftBrace) {
      report(.multilineIfBrace, node.ifKeyword)
    }
    if !externalBreak,
       let last,
       layout.line(node.conditions) != layout.endLine(last),
       layout.endLine(last) != layout.line(node.body.leftBrace)
    {
      report(.ifArgumentBraceNewline, node.ifKeyword)
    }
  }

  private func simpleExit(_ block: CodeBlockSyntax, permitsNestedBody: Bool = false) -> CodeBlockItemSyntax? {
    guard block.statements.count == 1, let statement = block.statements.first else { return nil }

    let item = statement.item
    let isExit = item.is(ReturnStmtSyntax.self)
      || item.is(ThrowStmtSyntax.self)
      || item.is(BreakStmtSyntax.self)
      || item.is(ContinueStmtSyntax.self)
    guard isExit else { return nil }

    if permitsNestedBody { return statement }

    let tokens = statement.tokens(viewMode: .sourceAccurate)
    let hasNestedBody = tokens.contains { $0.tokenKind == .leftBrace || $0.tokenKind == .semicolon }
    guard !hasNestedBody else { return nil }

    return statement
  }

  private func checkSingleLineBody(_ block: CodeBlockSyntax, rule: StyleRule, at keyword: TokenSyntax) {
    if layout.line(block.leftBrace) == layout.line(block.rightBrace),
       simpleExit(block, permitsNestedBody: true) == nil
    {
      report(rule, keyword)
    }
  }

  private func checkElse(_ block: CodeBlockSyntax, keyword: TokenSyntax) {
    checkSingleLineBody(block, rule: .singleLineElseExit, at: keyword)
    guard
      layout.line(block.leftBrace) == layout.line(block.rightBrace),
      let next = block.rightBrace.nextToken(viewMode: .sourceAccurate),
      layout.line(next) == layout.line(block.rightBrace) + 1,
      !["}", ")", "]", "else", "catch", "#endif", "#else", "#elseif", ""].contains(next.text)
    else { return }

    report(.compactElseBlankLine, keyword)
  }

  private func checkInlineBlock(_ node: Syntax, brace: TokenSyntax) {
    let isBlock = node.is(CodeBlockSyntax.self)
      || node.is(MemberBlockSyntax.self)
      || node.is(AccessorBlockSyntax.self)
      || node.is(ClosureExprSyntax.self)
    guard isBlock else { return }

    if let closure = node.as(ClosureExprSyntax.self), closure.signature != nil { return }

    guard
      let first = brace.nextToken(viewMode: .sourceAccurate),
      let last = node.lastToken(viewMode: .sourceAccurate),
      layout.line(first) == layout.line(brace),
      layout.line(last) > layout.line(brace),
      !layout.hasComments(brace)
    else { return }

    report(.multilineInlineBlock, brace)
  }

  private func isGlobal(_ node: FunctionDeclSyntax) -> Bool {
    var parent = node.parent
    while let current = parent {
      if current.is(MemberBlockSyntax.self) || current.is(CodeBlockSyntax.self) || current.is(ClosureExprSyntax.self) {
        return false
      }
      parent = current.parent
    }
    return true
  }
}

extension SyntaxProtocol {
  func ancestorIs<T: SyntaxProtocol>(_ type: T.Type) -> Bool {
    var current = parent
    while let node = current {
      if node.is(type) { return true }

      current = node.parent
    }
    return false
  }
}
