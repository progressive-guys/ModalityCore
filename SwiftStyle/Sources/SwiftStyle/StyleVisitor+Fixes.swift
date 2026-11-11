import SwiftSyntax

extension StyleVisitor {

  /// Uses the diagnostic decision to select a token-preserving layout change.
  func fix(_ rule: StyleRule, at token: TokenSyntax) {
    guard permitsFix(rule) else { return }

    switch rule {
    case .assignmentRhsSameLine:
      after(token, with: " ")

    case .selfMemberNewline:
      after(token, with: "")

    case .castOperatorNewline:
      before(token, with: " ")

    case .returnArrowNewline:
      before(token, with: " ")
      after(token, with: " ")

    case .splitReturnTypeMember:
      before(token, with: "")

    case .multilineReturnType:
      switch (token.ancestor(ReturnClauseSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .returnClause(let clause)?:
        join(clause.type)
      default:
        break
      }

    case .binaryOperatorWrap, .comparisonOperatorNewline, .arithmeticOperatorEndOfLine:
      switch (token.ancestor(InfixOperatorExprSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .infixOperatorExpr(let operation)?:
        if rule == .comparisonOperatorNewline, !layout.startsLine(token),
           let previous = token.previousToken(viewMode: .sourceAccurate),
           (previous.trailingTrivia.description + token.leadingTrivia.description).allSatisfy(\.isWhitespace)
        {
          indentContinuationLines(
            of: operation.rightOperand,
            by: layout.indent(operation) + 2 - layout.indent(operation.rightOperand)
          )
        }

        before(token, with: lineBreak(indent: layout.indent(operation) + 2))
        after(token, with: " ")

      default:
        break
      }

    case .mixedAdditiveExpressionWrap, .mixedMultiplicativeExpressionWrap,
      .mixedBooleanConditionWrap, .mixedNilCoalescingWrap:
      switch (token.ancestor(InfixOperatorExprSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .infixOperatorExpr(let operation)?:
        for part in chainOperations(operation, rule: rule) {
          guard let symbol = part.operator.firstToken(viewMode: .sourceAccurate) else { continue }
          before(symbol, with: lineBreak(indent: layout.indent(operation) + 2))
          after(symbol, with: " ")
        }

      default:
        break
      }

    case .arithmeticCallArgumentsWrap:
      switch (token.ancestor(InfixOperatorExprSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .infixOperatorExpr(let operation)?:
        for operand in [operation.leftOperand, operation.rightOperand] {
          guard case .functionCallExpr(let call) = operand.as(ExprSyntaxEnum.self) else { continue }

          let right = operand.id == operation.rightOperand.id
          if right, !["+", "-", "*", "/", "%"].contains(token.text) { continue }

          let column = layout.converter.location(for: call.positionAfterSkippingLeadingTrivia).column - 1
          guard canJoinArithmeticCall(call, column: right ? layout.indent(operation) + 2 : column) else { continue }
          join(call)

          if right, column + SourceLayout.compact(call.trimmedDescription).count > 120 {
            before(token, with: lineBreak(indent: layout.indent(operation) + 2))
            after(token, with: " ")
          }
        }

      default:
        break
      }

    case .binaryOperandMemberWrap, .arithmeticMemberWrap, .nilCoalescingMemberWrap:
      switch (token.ancestor(InfixOperatorExprSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .infixOperatorExpr(let operation)?:
        let operands = rule == .arithmeticMemberWrap
          ? [operation.leftOperand, operation.rightOperand]
          : [operation.rightOperand]
        for operand in operands {
          for member in memberChain(operand) { before(member.period, with: "") }
        }

        if rule == .nilCoalescingMemberWrap { after(token, with: " ") }

      default:
        break
      }

    case .longNilCoalescing:
      before(token, with: lineBreak(indent: layout.indent(token) + 2))
      after(token, with: " ")

    case .chainedCallArgumentsWrap, .chainedClosureNewline:
      switch (token.ancestor(FunctionCallExprSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .functionCallExpr(let call)?:
        before(token, with: lineBreak(indent: layout.indent(call) + 2))
      default:
        break
      }

    case .chainedClosureSameLine:
      before(token, with: "")

    case .multilineListElementChain:
      if let call = token.ancestor(FunctionCallExprSyntax.self), let closing = call.rightParen {
        let indent = layout.indent(call) + 2

        before(token, with: "")

        for argument in call.arguments {
          if let first = argument.firstToken(viewMode: .sourceAccurate) {
            before(first, with: lineBreak(indent: indent + 2))
          }
        }
        before(closing, with: lineBreak(indent: indent))
        after(closing, with: "")
      }

    case .mixedMemberChainWrap:
      if let expression = chainRoot(token) {
        let members = memberChain(expression)
        let leading = members.firstIndex { layout.startsLine($0.period) } ?? 1
        for part in members.dropFirst(min(leading, 1)) where part.base != nil {
          if let call = part.parent?.as(FunctionCallExprSyntax.self),
             isMultilineListElementChain(call) || joinsChainedClosure(call)
          { continue }

          before(part.period, with: lineBreak(indent: layout.indent(expression) + 2))
        }
      }

    case .multilineExpressionClosingDelimiter:
      if let expression = token.parent { before(token, with: lineBreak(indent: layout.indent(expression))) }

    case .mixedIfConditions:
      switch (token.ancestor(IfExprSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .ifExpr(let conditional)?:
        for condition in conditional.conditions.dropFirst() {
          if let first = condition.firstToken(viewMode: .sourceAccurate) {
            before(first, with: lineBreak(indent: layout.indent(conditional) + 2))
          }
        }

      default:
        break
      }

    case .multilineIfBrace, .ifArgumentBraceNewline:
      switch (token.ancestor(IfExprSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .ifExpr(let conditional)?:
        before(
          conditional.body.leftBrace,
          with: rule == .multilineIfBrace
            ? lineBreak(indent: layout.indent(conditional))
            : " "
        )

      default:
        break
      }

    case .ifExpressionBindingSameLine:
      switch (token.ancestor(VariableDeclSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .variableDecl(let declaration)?:
        for binding in declaration.bindings {
          if let initializer = binding.initializer {
            switch (Syntax(initializer.value).as(SyntaxEnum.self)) {
          case .ifExpr(let conditional):
            let tokens = Array(declaration.tokens(viewMode: .sourceAccurate))
              .prefix { $0.position < conditional.ifKeyword.position }
            for part in tokens {
              if let next = part.nextToken(viewMode: .sourceAccurate), layout.endLine(part) != layout.line(next) {
                after(part, with: " ")
              }
            }

          default:
            break
          }
          }
        }

      default:
        break
      }

    case .ifExpressionConditionIndent:
      switch (token.ancestor(IfExprSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .ifExpr(let conditional)?:
        switch (conditional.ancestor(VariableDeclSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
        case .variableDecl(let declaration)?:
          for segment in layout.headerSegments(Syntax(conditional.conditions)) {
          if let first = segment.firstToken(viewMode: .sourceAccurate), layout.startsLine(first),
             layout.line(first) > layout.line(conditional.ifKeyword)
          { before(first, with: lineBreak(indent: layout.indent(declaration) + 2)) }
        }

        default:
          break
        }

      default:
        break
      }

    case .multilineGuardConditions:
      switch (token.ancestor(GuardStmtSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .guardStmt(let statement)?:
        for condition in statement.conditions {
          if let first = condition.firstToken(viewMode: .sourceAccurate) {
            before(first, with: lineBreak(indent: layout.indent(statement) + 2))
          }
        }

        before(statement.elseKeyword, with: lineBreak(indent: layout.indent(statement)))

      default:
        break
      }

    case .compactGuardExit:
      switch (token.ancestor(GuardStmtSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .guardStmt(let statement)?:
        join(statement.body)
      default:
        break
      }

    case .singleLineIfExit, .singleLineElseExit:
      let block = token.ancestor(IfExprSyntax.self).flatMap { conditional in
        rule == .singleLineIfExit ? conditional.body : conditional.elseBody?.as(CodeBlockSyntax.self)
      } ?? token.ancestor(GuardStmtSyntax.self)?.body
      if let block {
        expand(block, indent: layout.indent(token))
      }

    case .multilineInlineBlock:
      after(token, with: lineBreak(indent: layout.indent(token) + 2))

    case .compactElseBlankLine:
      let block = token.ancestor(GuardStmtSyntax.self)?.body
        ?? token.ancestor(IfExprSyntax.self)?.elseBody?.as(CodeBlockSyntax.self)
      if let block { after(block.rightBrace, with: newline + lineBreak(indent: layout.indent(token))) }

    case .enumCaseNewline:
      switch (token.ancestor(EnumDeclSyntax.self).map { Syntax($0).as(SyntaxEnum.self) }) {
      case .enumDecl(let declaration)?:
        for member in declaration.memberBlock.members where member.decl.is(EnumCaseDeclSyntax.self) {
          if let first = member.firstToken(viewMode: .sourceAccurate), layout.line(first) == layout.line(token) {
            before(first, with: lineBreak(indent: layout.indent(declaration) + 2))
          }
        }

        before(declaration.memberBlock.rightBrace, with: lineBreak(indent: layout.indent(declaration)))

      default:
        break
      }

    case .memberSpacing:
      if token.tokenKind == .leftBrace {
        switch (Syntax(token.parent)?.as(SyntaxEnum.self)) {
        case .memberBlock(let block)?:
          if let first = block.members.first?.firstToken(viewMode: .sourceAccurate),
             layout.line(first) == layout.line(token)
          {
            before(
              first,
              with: String(repeating: newline, count: memberOpeningBlankLines(block.members))
                + lineBreak(indent: layout.indent(block) + 2)
            )
          }

        default:
          break
        }
      }

    default: break
    }
  }

  private func chainRoot(_ token: TokenSyntax) -> ExprSyntax? {
    var current = token.parent
    var result: ExprSyntax?
    while let node = current {
      if let expression = node.as(ExprSyntax.self) {
        switch expression.as(ExprSyntaxEnum.self) {
        case .declReferenceExpr, .stringLiteralExpr, .memberAccessExpr, .functionCallExpr, .subscriptCallExpr,
          .optionalChainingExpr, .forceUnwrapExpr, .genericSpecializationExpr:
          result = expression

        default: return result
        }
      } else { return result }

      current = node.parent
    }
    return result
  }

  private func expand(_ block: CodeBlockSyntax, indent: Int) {
    for statement in block.statements {
      if let first = statement.firstToken(viewMode: .sourceAccurate) {
        before(first, with: lineBreak(indent: indent + 2))
      }
    }

    before(block.rightBrace, with: lineBreak(indent: indent))
  }
}

extension SyntaxProtocol {

  /// Finds the owner of a diagnostic token in the current syntax tree.
  func ancestor<T: SyntaxProtocol>(_ type: T.Type) -> T? {
    var current: Syntax? = Syntax(self)
    while let node = current {
      if let value = node.as(type) { return value }
      current = node.parent
    }

    return nil
  }
}
