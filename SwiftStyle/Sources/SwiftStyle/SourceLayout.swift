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

  /// Keeps adjacent single-line elements together. Uses one blank line if either element spans multiple lines.
  /// Includes attached comments in each element. Places separation before the next element's leading comments.
  func elementSpacing(
    between previous: some SyntaxProtocol,
    and current: some SyntaxProtocol
  ) -> (blankLines: Range<Int>, required: Int)? {
    let previousEnd = commentedEndLine(previous)
    let currentStart = commentedStartLine(current)
    guard previousEnd < currentStart else { return nil }

    let compact = commentedStartLine(previous) == previousEnd && currentStart == commentedEndLine(current)
    return ((previousEnd + 1)..<currentStart, compact ? 0 : 1)
  }

  private func commentedStartLine(_ node: some SyntaxProtocol) -> Int {
    var position = node.position
    for piece in node.leadingTrivia {
      switch piece {
      case .lineComment, .docLineComment, .blockComment, .docBlockComment:
        return converter.location(for: position).line

      default: position = position.advanced(by: piece.sourceLength.utf8Length)
      }
    }
    return line(node)
  }

  private func commentedEndLine(_ node: some SyntaxProtocol) -> Int {
    var position = node.endPositionBeforeTrailingTrivia
    var result = endLine(node)
    for piece in node.trailingTrivia {
      let length = piece.sourceLength.utf8Length
      switch piece {
      case .lineComment, .docLineComment, .blockComment, .docBlockComment:
        result = converter.location(for: position.advanced(by: length - 1)).line

      default: break
      }
      position = position.advanced(by: length)
    }
    return result
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
