import Foundation
import SwiftSyntax

/// Replaces a UTF-8 source range. Offsets refer to the current parse.
struct SourceEdit {

  let range: Range<Int>
  let replacement: String

  var priority: Int

  init(range: Range<Int>, replacement: String, priority: Int = 0) {
    self.range = range
    self.replacement = replacement
    self.priority = priority
  }

  /// Applies disjoint edits from the end. The next parse resolves overlapping edits.
  static func apply(_ edits: [SourceEdit], to source: String) -> String {
    var bytes = Array(source.utf8)
    var boundary = bytes.count + 1
    let priority = edits.map(\.priority).max() ?? 0
    for edit in edits.filter({ $0.priority == priority }).sorted(by: { $0.range.lowerBound > $1.range.lowerBound }) {
      guard edit.range.upperBound < boundary else { continue }
      bytes.replaceSubrange(edit.range, with: edit.replacement.utf8)
      boundary = edit.range.lowerBound
    }
    return String(decoding: bytes, as: UTF8.self)
  }
}

extension StyleVisitor {

  var newline: String { source.contains("\r\n") ? "\r\n" : "\n" }

  /// Changes blank lines before attached comments. Keeps comment text and indentation.
  func fixSpacing(_ lines: Range<Int>, required: Int, rule: StyleRule) {
    guard permitsFix(rule), lines.count != required else { return }

    let start = layout.lines.prefix(lines.lowerBound - 1).reduce(0) { $0 + $1.utf8.count + newline.utf8.count }

    let length = layout.lines[(lines.lowerBound - 1)..<(lines.upperBound - 1)]
      .reduce(0) { $0 + $1.utf8.count + newline.utf8.count }

    edits.append(SourceEdit(range: start..<(start + length), replacement: String(repeating: newline, count: required)))
  }

  func permitsFix(_ rule: StyleRule) -> Bool {
    isFormatting && (fixingRules?.contains(rule.rawValue) ?? true)
  }

  /// Replaces a gap only when it contains whitespace. Comments always remain in place.
  func gap(after left: TokenSyntax, before right: TokenSyntax, with replacement: String) {
    let range = left.endPositionBeforeTrailingTrivia.utf8Offset..<right.positionAfterSkippingLeadingTrivia.utf8Offset
    guard range.lowerBound <= range.upperBound else { return }
    let existing = String(decoding: Array(source.utf8)[range], as: UTF8.self)
    guard existing.allSatisfy(\.isWhitespace), existing != replacement else { return }
    edits.append(SourceEdit(range: range, replacement: replacement, priority: editPriority))
  }

  func before(_ token: TokenSyntax, with replacement: String) {
    guard let previous = token.previousToken(viewMode: .sourceAccurate) else { return }
    gap(after: previous, before: token, with: replacement)
  }

  func after(_ token: TokenSyntax, with replacement: String) {
    guard let next = token.nextToken(viewMode: .sourceAccurate) else { return }
    gap(after: token, before: next, with: replacement)
  }

  func lineBreak(indent: Int) -> String {
    newline + String(repeating: " ", count: max(0, indent))
  }

  /// Joins token gaps, including member access, without changing token text.
  func join(_ node: some SyntaxProtocol) {
    let tokens = Array(node.tokens(viewMode: .sourceAccurate))
    for (left, right) in zip(tokens, tokens.dropFirst()) where layout.endLine(left) != layout.line(right) {
      let tight = [".", ")", "]", ",", ">", "?", "!"].contains(right.text)
        || [".", "(", "[", "<"].contains(left.text)
      gap(after: left, before: right, with: tight ? "" : " ")
    }
  }
}
