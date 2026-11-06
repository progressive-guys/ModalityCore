import Foundation
import SwiftParser
import SwiftSyntax

/// Makes local syntax changes with a defined owner and evaluation order.
final class StructuralFormatter: SyntaxVisitor {

  let source: String
  let layout: SourceLayout

  var edits: [SourceEdit] = []

  private let rules: Set<String>?

  init(source: String, tree: SourceFileSyntax, rules: Set<String>?) {
    self.source = source
    layout = SourceLayout(source: source, file: "<format>", tree: tree)
    self.rules = rules
    super.init(viewMode: .sourceAccurate)
  }

  /// A comma keeps short-circuit evaluation and the scope of optional bindings.
  override func visit(_ node: IfExprSyntax) -> SyntaxVisitorContinueKind {
    guard enabled(.collapsibleNestedIf), node.elseBody == nil, node.body.statements.count == 1,
          let statement = node.body.statements.first?.item.as(ExpressionStmtSyntax.self),
          let nested = statement.expression.as(IfExprSyntax.self), nested.elseBody == nil,
          bindings(node.conditions).isDisjoint(with: bindings(nested.conditions))
    else { return .visitChildren }

    let start = node.body.leftBrace.positionAfterSkippingLeadingTrivia.utf8Offset
    let afterBrace = node.body.leftBrace.endPositionBeforeTrailingTrivia.utf8Offset
    let beforeIf = nested.ifKeyword.positionAfterSkippingLeadingTrivia.utf8Offset
    let end = nested.ifKeyword.endPositionBeforeTrailingTrivia.utf8Offset
    let trivia = String(decoding: Array(source.utf8)[afterBrace..<beforeIf], as: UTF8.self)
    edits.append(SourceEdit(range: start..<end, replacement: "," + trivia))

    let innerEnd = nested.body.rightBrace.endPositionBeforeTrailingTrivia.utf8Offset
    let outerStart = node.body.rightBrace.positionAfterSkippingLeadingTrivia.utf8Offset
    let outerEnd = node.body.rightBrace.endPositionBeforeTrailingTrivia.utf8Offset
    let closingTrivia = String(decoding: Array(source.utf8)[innerEnd..<outerStart], as: UTF8.self)
    edits.append(SourceEdit(range: innerEnd..<outerEnd, replacement: closingTrivia))

    return .skipChildren
  }

  /// Moves complete declarations, including their comments and initializers.
  override func visit(_ node: MemberBlockItemListSyntax) -> SyntaxVisitorContinueKind {
    if enabled(.privateViewProperties) {
      let access = ViewPropertyAccess.edits(in: node, layout: layout)
      if !access.isEmpty {
        edits += access
        return .skipChildren
      }
    }

    if enabled(.memberOrder) {
      let order = MemberOrderFormatter.edits(in: node)
      if !order.isEmpty {
        edits += order
        return .skipChildren
      }
    }

    if enabled(.propertyGrouping) { edits += PropertyOrderFormatter.edits(in: node, layout: layout) }

    return .visitChildren
  }

  /// The parser decodes raw and escaped literals. Interpolated text remains unchanged.
  override func visit(_ node: SequenceExprSyntax) -> SyntaxVisitorContinueKind {
    guard enabled(.concatenatedStringLiterals) else { return .visitChildren }

    let elements = Array(node.elements)
    guard elements.count >= 3, elements.count % 2 == 1 else { return .visitChildren }

    var value = ""

    for (index, element) in elements.enumerated() {
      if index % 2 == 1 {
        guard element.as(BinaryOperatorExprSyntax.self)?.operator.text == "+" else { return .visitChildren }
      } else {
        guard let literal = element.as(StringLiteralExprSyntax.self), let text = literal.representedLiteralValue
        else { return .visitChildren }
        value += text
      }
    }

    guard !node.tokens(viewMode: .sourceAccurate).contains(where: { token in
      (token.leadingTrivia + token.trailingTrivia).contains { piece in
        switch piece {
        case .lineComment, .docLineComment, .blockComment, .docBlockComment: true
        default: false
        }
      }
    })
    else { return .visitChildren }

    edits.append(SourceEdit(
      range: node.positionAfterSkippingLeadingTrivia.utf8Offset..<node.endPositionBeforeTrailingTrivia.utf8Offset,
      replacement: literal(value, at: node)
    ))

    return .skipChildren
  }

  /// Keeps interpolation expressions and existing escapes while removing multiline delimiters.
  override func visit(_ node: StringLiteralExprSyntax) -> SyntaxVisitorContinueKind {
    if enabled(.multilineStringIndent), let edit = MultilineStringFormatter.edit(node, layout: layout) {
      edits.append(edit)
      return .visitChildren
    }

    guard enabled(.singleLineInterpolatedString), node.openingPounds == nil,
          node.openingQuote.tokenKind == .multilineStringQuote,
          node.segments.contains(where: { $0.is(ExpressionSegmentSyntax.self) })
    else { return .visitChildren }

    let start = layout.line(node)
    let end = layout.endLine(node)
    guard end - start == 2, !node.trimmedDescription.contains("\\n"),
          !node.trimmedDescription.contains("\\r"), !node.trimmedDescription.contains("\\u{")
    else { return .visitChildren }

    var contents = ""
    for segment in node.segments {
      switch segment {
      case .stringSegment(let text):
        var escaped = false
        for character in text.content.text {
          if character == "\"", !escaped { contents += "\\" }
          contents.append(character)
          escaped = character == "\\" && !escaped
        }

      case .expressionSegment(let expression): contents += expression.trimmedDescription
      @unknown default: return .visitChildren
      }
    }
    edits.append(SourceEdit(
      range: node.positionAfterSkippingLeadingTrivia.utf8Offset..<node.endPositionBeforeTrailingTrivia.utf8Offset,
      replacement: "\"" + contents + "\""
    ))

    return .skipChildren
  }

  /// A repeated binding can introduce a new scope. Keep such branches for review.
  private func bindings(_ conditions: ConditionElementListSyntax) -> Set<String> {
    Set(conditions.flatMap { condition -> [String] in
      let pattern: PatternSyntax? = switch condition.condition {
      case .optionalBinding(let binding): binding.pattern
      case .matchingPattern(let matching): matching.pattern
      default: nil
      }
      return pattern?.tokens(viewMode: .sourceAccurate).compactMap { token in
        if case .identifier = token.tokenKind { return token.text }
        return nil
      } ?? []
    })
  }

  func enabled(_ rule: StyleRule) -> Bool {
    rules?.contains(rule.rawValue) ?? true
  }

  /// Encodes Swift string contents, including backslashes that could start an interpolation.
  private func literal(_ value: String, at node: some SyntaxProtocol) -> String {
    let parts = value.unicodeScalars.map { scalar -> String in
      switch scalar {
      case "\"": "\\\""
      case "\\": "\\\\"
      case "\n": "\\n"
      case "\r": "\\r"
      case "\t": "\\t"
      case "\0": "\\0"
      default: String(scalar)
      }
    }
    let contents = parts.joined()
    let column = layout.converter.location(for: node.positionAfterSkippingLeadingTrivia).column
    if column + contents.count + 1 <= 120 { return "\"" + contents + "\"" }

    let newline = source.contains("\r\n") ? "\r\n" : "\n"
    let indent = String(repeating: " ", count: layout.indent(node) + 2)
    var lines: [String] = []
    var line = ""

    for part in parts {
      if !line.isEmpty, indent.count + line.count + part.count + 1 > 120 {
        lines.append(line)
        line = ""
      }

      line += part
    }
    lines.append(line)

    return "\"\"\""
      + newline
      + indent
      + lines.joined(separator: "\\" + newline + indent)
      + newline
      + indent
      + "\"\"\""
  }
}
