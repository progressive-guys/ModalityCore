import SwiftParser
import SwiftSyntax
import SwiftOperators
import SwiftParserDiagnostics

/// Applies layout fixes until the selected rules make no further changes.
enum SourceFormatter {

  static func format(_ source: String, file: String, rules: Set<String>?) -> String {
    var result = source
    var seen: Set<String> = [source]

    for _ in 0..<100 {
      let parsed = Parser.parse(source: result)

      guard ParseDiagnosticsGenerator.diagnostics(for: parsed).isEmpty else { return result }

      var operators = OperatorTable.standardOperators
      operators.addSourceFile(parsed, errorHandler: { _ in })

      let folded = operators.foldAll(parsed, errorHandler: { _ in })
      let visitor = StyleVisitor(file: file, source: result, tree: parsed, fixingRules: rules, isFormatting: true)
      visitor.walk(folded)

      let structural = StructuralFormatter(source: result, tree: parsed, rules: rules)
      structural.walk(parsed)
      DispatchVisitor(formatter: structural).walk(folded)

      // Use separate passes so structural edits cannot invalidate layout offsets.
      let changesSyntax = !structural.edits.isEmpty
      let candidate = SourceEdit.apply(changesSyntax ? structural.edits : visitor.edits, to: result)

      guard candidate != result else { return result }

      let next = Parser.parse(source: candidate)

      guard ParseDiagnosticsGenerator.diagnostics(for: next).isEmpty,
            (changesSyntax || tokens(parsed) == tokens(next)), comments(parsed).sorted() == comments(next).sorted(),
            seen.insert(candidate).inserted
      else { return result }

      result = candidate
    }

    return result
  }

  /// Trivia edits must preserve every token, including literal contents and operator spelling.
  private static func tokens(_ tree: SourceFileSyntax) -> [String] {
    tree.tokens(viewMode: .sourceAccurate).map(\.text)
  }

  /// Structural fixes also keep the complete comment sequence.
  static func comments(_ tree: SourceFileSyntax) -> [String] {
    tree.tokens(viewMode: .sourceAccurate).flatMap { token in
      (token.leadingTrivia + token.trailingTrivia).compactMap { piece in
        switch piece {
        case .lineComment(let text), .docLineComment(let text), .blockComment(let text), .docBlockComment(let text): text
        default: nil
        }
      }
    }
  }

}
