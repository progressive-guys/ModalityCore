import Foundation
import SwiftSyntax

/// Changes common literal indentation. Multiline interpolation expressions keep their diagnostic.
enum MultilineStringFormatter {

  /// Standalone opening quotes share their indent with the contents and closing quotes.
  static func contentIndent(_ node: StringLiteralExprSyntax, layout: SourceLayout) -> Int {
    let opening = node.openingPounds ?? node.openingQuote
    return layout.indent(node) + (layout.startsLine(opening) ? 0 : 2)
  }

  static func edit(_ node: StringLiteralExprSyntax, layout: SourceLayout) -> SourceEdit? {
    guard node.openingQuote.tokenKind == .multilineStringQuote,
          layout.indent(node.closingQuote) != contentIndent(node, layout: layout)
    else { return nil }

    let source = node.trimmedDescription
    let newline = source.contains("\r\n") ? "\r\n" : "\n"
    let lines = source.components(separatedBy: newline)

    guard let first = lines.first, let last = lines.last, lines.count > 1 else { return nil }

    let oldIndent = String(last.prefix(while: { $0 == " " || $0 == "\t" }))
    let indent = String(repeating: " ", count: contentIndent(node, layout: layout))

    let hasMultilineInterpolation = node.segments.contains { segment in
      switch segment {
      case .expressionSegment(let expression): layout.line(expression) != layout.endLine(expression)
      default: false
      }
    }

    guard !hasMultilineInterpolation else { return nil }

    var result = [first]

    for line in lines.dropFirst() {
      if line.hasPrefix(oldIndent) {
        result.append(indent + line.dropFirst(oldIndent.count))
      } else if line.allSatisfy({ $0 == " " || $0 == "\t" }) {
        result.append(indent)
      } else {
        result.append(line)
      }
    }

    return SourceEdit(
      range: node.positionAfterSkippingLeadingTrivia.utf8Offset..<node.endPositionBeforeTrailingTrivia.utf8Offset,
      replacement: result.joined(separator: newline)
    )
  }
}
