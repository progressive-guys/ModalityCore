import Foundation
import SwiftParser
import SwiftSyntax

extension StructuralFormatter {

  /// Changes one projection at a time. Separate checks keep separate receiver evaluations.
  func fixSyntaxDispatch(_ conditional: IfExprSyntax) -> Bool {

    let conditions = Array(conditional.conditions)

    for (index, condition) in conditions.enumerated() {
      let projection: DispatchProjection
      let binding: String?
      let negated: Bool

      switch condition.condition {
      case .optionalBinding(let item):
        guard item.typeAnnotation == nil, let value = item.initializer?.value,
              needsTypeSwitch(value, in: conditional),
              let parsed = DispatchProjection(value, rules: self, allowWrapper: true), !parsed.isTest
        else { continue }

        projection = parsed
        binding = item.bindingSpecifier.text + " " + item.pattern.trimmedDescription
        negated = false

      case .expression(let expression):
        guard needsTypeSwitch(expression, in: conditional) else { continue }

        if let prefix = ({ () -> PrefixOperatorExprSyntax? in
          switch (Syntax(expression).as(SyntaxEnum.self)) {
          case .prefixOperatorExpr(let value): return value
          default: return nil
          }
        }()), prefix.operator.text == "!",
           let parsed = DispatchProjection(prefix.expression, rules: self), parsed.isTest
        {
          projection = parsed
          negated = true
        } else if let parsed = DispatchProjection(expression, rules: self), parsed.isTest {
          projection = parsed
          negated = false
        } else { continue }

        binding = nil

      default: continue
      }

      // A switch must not capture a break that belongs to an enclosing loop or switch.
      guard !conditional.body.statements.contains(where: { hasOuterBreak(Syntax($0)) }) else { continue }

      let prefix = Array(conditions.prefix(index))
      let suffix = Array(conditions.dropFirst(index + 1))

      guard prefix.isEmpty || conditional.elseBody == nil, !negated || suffix.isEmpty else { continue }

      let expressions = suffix.compactMap { element -> ExprSyntax? in
        switch element.condition {
        case .expression(let expression): expression
        default: nil
        }
      }

      guard expressions.count == suffix.count || conditional.elseBody == nil else { continue }

      guard let replacement = dispatch(
        conditional,
        projection: projection,
        binding: binding,
        negated: negated,
        prefix: prefix,
        suffix: suffix,
        expressions: expressions
      )
      else { continue }

      guard SourceFormatter.comments(Parser.parse(source: conditional.trimmedDescription)).sorted()
        == SourceFormatter.comments(Parser.parse(source: replacement)).sorted()
      else { continue }

      let start = conditional.positionAfterSkippingLeadingTrivia.utf8Offset
      let end = conditional.endPositionBeforeTrailingTrivia.utf8Offset
      edits.append(SourceEdit(range: start..<end, replacement: replacement))

      return true
    }

    return false
  }

  /// Keeps unrelated checks in the same condition unchanged.
  func needsTypeSwitch(_ expression: ExprSyntax, in conditional: IfExprSyntax) -> Bool {
    enabled(.preferSyntaxKindSwitch)
      && TypeCheckSequence.contains(expression, in: conditional, rule: .preferSyntaxKindSwitch)
      || enabled(.preferTypeSwitch)
      && TypeCheckSequence.contains(expression, in: conditional, rule: .preferTypeSwitch)
  }

  private func dispatch(
    _ conditional: IfExprSyntax,
    projection: DispatchProjection,
    binding: String?,
    negated: Bool,
    prefix: [ConditionElementSyntax],
    suffix: [ConditionElementSyntax],
    expressions: [ExprSyntax]
  ) -> String? {
    let newline = source.contains("\r\n") ? "\r\n" : "\n"
    let indent = String(repeating: " ", count: layout.indent(conditional))
    let body = blockContents(conditional.body)
    let fallback: String

    switch conditional.elseBody {
    case .codeBlock(let block): fallback = blockContents(block)
    case .ifExpr(let branch): fallback = branch.description
    case nil: fallback = "break"
    @unknown default: return nil
    }

    let receiver = "(" + projection.subject + ")"
    var pattern = projection.pattern(binding: binding)
    let success: String

    if suffix.isEmpty || expressions.count == suffix.count {
      if !suffix.isEmpty {
        pattern += " where " + expressions.map { "(\($0.trimmedDescription))" }.joined(separator: " && ")
      }

      success = body
    } else {
      success = "if " + conditionText(suffix) + " {" + body + newline + indent + "}"
    }

    let matched = negated ? fallback : success
    let other = negated ? success : fallback

    var result = "switch \(receiver) {"
      + newline
      + indent
      + "case \(pattern):"
      + newline
      + indent
      + "  "
      + matched
      + newline
      + indent
      + "default:"
      + newline
      + indent
      + "  "
      + other
      + newline
      + indent
      + "}"

    if !prefix.isEmpty {
      result = "if "
        + conditionText(prefix)
        + " {"
        + newline
        + indent
        + "  "
        + result
        + newline
        + indent
        + "}"
    }

    return result
  }

  private func blockContents(_ block: CodeBlockSyntax) -> String {
    let start = block.leftBrace.endPositionBeforeTrailingTrivia.utf8Offset
    let end = block.rightBrace.positionAfterSkippingLeadingTrivia.utf8Offset

    return String(decoding: Array(source.utf8)[start..<end], as: UTF8.self)
      .trimmingCharacters(in: .whitespacesAndNewlines)
  }

  private func conditionText(_ conditions: [ConditionElementSyntax]) -> String {
    conditions.map { $0.with(\.trailingComma, nil).trimmedDescription }.joined(separator: ", ")
  }

  private func hasOuterBreak(_ node: Syntax) -> Bool {
    switch node.as(SyntaxEnum.self) {
    case .breakStmt(let statement): return statement.label == nil
    case .switchExpr, .forStmt, .whileStmt, .repeatStmt, .closureExpr: return false
    default: return node.children(viewMode: .sourceAccurate).contains { hasOuterBreak($0) }
    }
  }
}

/// Identifies a concrete SwiftSyntax type from the active toolchain.
struct SyntaxProjection {

  let kind: String
  let method: String
  let subject: String
  let typeName: String

  let optional: Bool

  private static let concreteTypes: Set<String> = {
    guard case .choices(let choices) = Syntax.structure else { return [] }

    return Set(choices.compactMap { choice in
      switch choice {
      case .node(let type): String(describing: type)
      case .token: nil
      @unknown default: nil
      }
    })
  }()

  init?(_ expression: ExprSyntax) {
    guard let call = expression.as(FunctionCallExprSyntax.self), call.arguments.count == 1,
          let member = call.calledExpression.as(MemberAccessExprSyntax.self), let base = member.base,
          let argument = call.arguments.first?.expression.as(MemberAccessExprSyntax.self),
          argument.declName.baseName.text == "self", let type = argument.base,
          let name = type.lastToken(viewMode: .sourceAccurate)?.text,
          Self.concreteTypes.contains(name)
    else { return nil }

    kind = Self.caseName(name)
    typeName = type.trimmedDescription
    method = member.declName.baseName.text

    if method == "as" || method == "is" {
      if Self.optionalReceiver(base) {
        let receiver = base.as(OptionalChainingExprSyntax.self)?.expression ?? base
        subject = "Syntax(\(receiver.trimmedDescription))?.as(SyntaxEnum.self)"
        optional = true
      } else {
        subject = "Syntax(\(base.trimmedDescription)).as(SyntaxEnum.self)"
        optional = false
      }
    } else {
      // A wrapper may have its own effects. Keep its call and optional result.
      subject = call.trimmedDescription + ".map { Syntax($0).as(SyntaxEnum.self) }"
      optional = true
    }
  }

  private static func optionalReceiver(_ expression: ExprSyntax) -> Bool {
    switch expression.as(ExprSyntaxEnum.self) {
    case .optionalChainingExpr: true
    case .memberAccessExpr(let member): member.base.map(optionalReceiver) ?? false
    case .functionCallExpr(let call): optionalReceiver(call.calledExpression)
    case .subscriptCallExpr(let call): optionalReceiver(call.calledExpression)
    case .genericSpecializationExpr(let generic): optionalReceiver(generic.expression)
    default: false
    }
  }

  static func isConcrete(_ type: String) -> Bool { concreteTypes.contains(type) }

  /// SwiftSyntax uses lowerCamelCase, including acronym prefixes such as ABI.
  private static func caseName(_ type: String) -> String {
    let stem = String(type.dropLast("Syntax".count))
    let prefix = stem.prefix(while: { $0 == "_" })
    let name = String(stem.dropFirst(prefix.count))
    let capitals = name.prefix(while: \.isUppercase).count
    let count = capitals > 1 && capitals < name.count ? capitals - 1 : max(1, capitals)

    return prefix + name.prefix(count).lowercased() + name.dropFirst(count)
  }
}

/// Visits folded conditions without changing literal operator sequences.
final class DispatchVisitor: SyntaxVisitor {

  private let formatter: StructuralFormatter

  init(formatter: StructuralFormatter) {
    self.formatter = formatter
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: IfExprSyntax) -> SyntaxVisitorContinueKind {
    guard formatter.enabled(.preferSyntaxKindSwitch) && TypeCheckSequence.contains(node, rule: .preferSyntaxKindSwitch)
      || formatter.enabled(.preferTypeSwitch) && TypeCheckSequence.contains(node, rule: .preferTypeSwitch)
    else { return .visitChildren }

    if formatter.fixSyntaxDispatch(node) { return .skipChildren }

    EmbeddedDispatchVisitor(formatter: formatter, conditional: node).walk(node.conditions)

    return .visitChildren
  }
}

struct DispatchProjection {

  let isTest: Bool
  let subject: String
  let nativeType: String?
  let syntax: SyntaxProjection?

  init?(_ expression: ExprSyntax, rules: StructuralFormatter, allowWrapper: Bool = false) {
    var value = expression

    while let tuple = value.as(TupleExprSyntax.self), tuple.elements.count == 1,
          let first = tuple.elements.first
    { value = first.expression }

    if rules.enabled(.preferSyntaxKindSwitch), let projection = SyntaxProjection(value),
       allowWrapper || ["as", "is"].contains(projection.method)
    {
      subject = projection.subject
      isTest = projection.method == "is"
      syntax = projection
      nativeType = nil

      return
    }

    guard rules.enabled(.preferTypeSwitch) else { return nil }

    switch value.as(ExprSyntaxEnum.self) {
    case .asExpr(let cast) where cast.questionOrExclamationMark?.tokenKind == .postfixQuestionMark:
      subject = cast.expression.trimmedDescription
      nativeType = cast.type.trimmedDescription
      isTest = false

    case .isExpr(let test):
      subject = test.expression.trimmedDescription
      nativeType = test.type.trimmedDescription
      isTest = true

    default: return nil
    }

    syntax = nil
  }

  func pattern(binding: String?) -> String {
    if let syntax {
      let bound = binding.map { "(\($0))" } ?? ""
      return ".\(syntax.kind)" + bound + (syntax.optional ? "?" : "")
    }

    guard let nativeType else { return "_" }

    return binding.map { "\($0) as \(nativeType)" } ?? "is \(nativeType)"
  }
}

/// Keeps short-circuit conditions in place when a direct branch rewrite is not possible.
final class EmbeddedDispatchVisitor: SyntaxVisitor {

  private let conditional: IfExprSyntax
  private let formatter: StructuralFormatter

  init(formatter: StructuralFormatter, conditional: IfExprSyntax) {
    self.formatter = formatter
    self.conditional = conditional
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: ClosureExprSyntax) -> SyntaxVisitorContinueKind { .skipChildren }

  override func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    replace(ExprSyntax(node))
  }

  override func visit(_ node: AsExprSyntax) -> SyntaxVisitorContinueKind {
    replace(ExprSyntax(node))
  }

  override func visit(_ node: IsExprSyntax) -> SyntaxVisitorContinueKind {
    replace(ExprSyntax(node))
  }

  private func replace(_ expression: ExprSyntax) -> SyntaxVisitorContinueKind {
    guard formatter.needsTypeSwitch(expression, in: conditional),
          expression.parent?.is(TryExprSyntax.self) != true,
          expression.parent?.is(AwaitExprSyntax.self) != true,
          let projection = DispatchProjection(expression, rules: formatter),
          !expression.tokens(viewMode: .sourceAccurate).contains(where: { ["await", "try"].contains($0.text) })
    else { return .visitChildren }

    let optionalTest = projection.isTest && projection.syntax?.optional == true

    let resultType = projection.isTest
      ? (optionalTest ? "Bool?" : "Bool")
      : (projection.syntax?.typeName ?? projection.nativeType ?? "Never") + "?"

    let pattern = projection.pattern(binding: projection.isTest ? nil : "let value")
    let value = projection.isTest ? "true" : "value"
    let fallback = projection.isTest ? "false" : "nil"
    let newline = formatter.source.contains("\r\n") ? "\r\n" : "\n"
    let indent = String(repeating: " ", count: formatter.layout.indent(expression))
    let missing = optionalTest ? "  case nil: return nil" + newline + indent : ""

    let replacement = "({ () -> \(resultType) in"
      + newline
      + indent
      + "  switch (\(projection.subject)) {"
      + newline
      + indent
      + "  case \(pattern): return \(value)"
      + newline
      + indent
      + missing
      + "  default: return \(fallback)"
      + newline
      + indent
      + "  }"
      + newline
      + indent
      + "}())"

    guard SourceFormatter.comments(Parser.parse(source: expression.trimmedDescription)).sorted()
      == SourceFormatter.comments(Parser.parse(source: replacement)).sorted()
    else { return .visitChildren }

    formatter.edits.append(SourceEdit(
      range: expression.positionAfterSkippingLeadingTrivia.utf8Offset..<expression.endPositionBeforeTrailingTrivia.utf8Offset,
      replacement: replacement
    ))

    return .skipChildren
  }
}
