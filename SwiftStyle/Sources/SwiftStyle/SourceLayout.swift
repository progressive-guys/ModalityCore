import Foundation
import SwiftSyntax

struct SourceLayout {
  let converter: SourceLocationConverter
  let lines: [String]

  init(source: String, file: String, tree: SourceFileSyntax) {
    converter = SourceLocationConverter(fileName: file, tree: tree)
    let normalized = source.replacingOccurrences(of: "\r\n", with: "\n")
    lines = normalized.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
  }

  func line(_ node: some SyntaxProtocol) -> Int {
    converter.location(for: node.positionAfterSkippingLeadingTrivia).line
  }

  func endLine(_ node: some SyntaxProtocol) -> Int {
    converter.location(for: node.endPositionBeforeTrailingTrivia).line
  }

  func indent(_ node: some SyntaxProtocol) -> Int {
    text(at: line(node)).prefix(while: { $0 == " " || $0 == "\t" }).count
  }

  func text(at line: Int) -> String {
    guard lines.indices.contains(line - 1) else { return "" }

    return lines[line - 1]
  }

  func startsLine(_ token: TokenSyntax) -> Bool {
    let location = converter.location(for: token.positionAfterSkippingLeadingTrivia)
    return text(at: location.line).utf8.prefix(location.column - 1).allSatisfy { $0 == 32 || $0 == 9 }
  }

  func hasComments(_ node: some SyntaxProtocol) -> Bool {
    node.tokens(viewMode: .sourceAccurate).contains { token in
      (token.leadingTrivia + token.trailingTrivia).contains { piece in
        switch piece {
        case .lineComment, .blockComment, .docLineComment, .docBlockComment: true

        default: false
        }
      }
    }
  }

  func compact(_ text: String) -> String {
    text.split(whereSeparator: \.isNewline).map { $0.trimmingCharacters(in: .whitespaces) }.joined(separator: " ")
  }

  /// Keeps calls, subscripts and closures as whole header segments.
  /// Line breaks inside these segments do not split a control-flow condition.
  func headerSegments(_ node: Syntax) -> [Syntax] {
    if node.is(FunctionCallExprSyntax.self)
      || node.is(SubscriptCallExprSyntax.self)
      || node.is(ClosureExprSyntax.self)
      || node.is(TupleExprSyntax.self)
      || node.is(StringLiteralExprSyntax.self)
      || node.is(RegexLiteralExprSyntax.self)
      || node.is(TokenSyntax.self)
    {
      return [node]
    }
    return node.children(viewMode: .sourceAccurate).flatMap { headerSegments($0) }
  }

  func headerBreaks(_ node: some SyntaxProtocol) -> Bool {
    let segments = headerSegments(Syntax(node))
    let nextSegments = segments.dropFirst()
    let hasBoundaryBreak = zip(segments, nextSegments).contains { endLine($0) != line($1) }
    if hasBoundaryBreak { return true }

    return receiverBreaks(Syntax(node))
  }

  private func receiverBreaks(_ node: Syntax) -> Bool {
    if let call = node.as(FunctionCallExprSyntax.self) { return headerBreaks(call.calledExpression) }

    if let indexed = node.as(SubscriptCallExprSyntax.self) { return headerBreaks(indexed.calledExpression) }

    if node.is(ClosureExprSyntax.self)
      || node.is(StringLiteralExprSyntax.self)
      || node.is(RegexLiteralExprSyntax.self)
    {
      return false
    }
    return node.children(viewMode: .sourceAccurate).contains { receiverBreaks($0) }
  }

}
