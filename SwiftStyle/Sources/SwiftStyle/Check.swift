import Foundation
import SwiftOperators
import SwiftParser
import SwiftParserDiagnostics
import SwiftSyntax

struct LintDiagnostic: Encodable {
  let file: String
  let line: Int
  let character: Int
  let ruleID: String
  let reason: String
  let severity = "Error"

  private enum CodingKeys: String, CodingKey {
    case file, line, character

    case ruleID = "rule_id"

    case reason, severity
  }
}

extension LintDiagnostic {
  static let rule = "complex_control_flow_condition"
  static let message = "Упростите условие: вынесите вызовы и вычисления в именованные переменные."

  var output: String {
    "\(file):\(line):\(character): error: \(reason) [\(ruleID)]"
  }
}

/// Checks if, guard and executable where clauses in for, case and catch, including bindings and patterns.
/// Reports one error per construct at its keyword. Skips while, repeat and generic constraints.
final class ConditionVisitor: SyntaxVisitor {
  private let file: String
  private let converter: SourceLocationConverter
  private(set) var diagnostics: [LintDiagnostic] = []

  init(file: String, tree: SourceFileSyntax) {
    self.file = file
    converter = SourceLocationConverter(fileName: file, tree: tree)
    super.init(viewMode: .sourceAccurate)
  }

  override func visit(_ node: IfExprSyntax) -> SyntaxVisitorContinueKind {
    check(node.conditions, at: node.ifKeyword)
    return .visitChildren
  }

  override func visit(_ node: GuardStmtSyntax) -> SyntaxVisitorContinueKind {
    check(node.conditions, at: node.guardKeyword)
    return .visitChildren
  }

  override func visit(_ node: WhereClauseSyntax) -> SyntaxVisitorContinueKind {
    if ExpressionPolicy.isComplex(node.condition) {
      report(node.whereKeyword)
    }

    return .visitChildren
  }

  private func check(_ conditions: ConditionElementListSyntax, at keyword: TokenSyntax) {
    let hasComplexCondition = conditions.contains { element in
      switch element.condition {
      case .expression(let expression): ExpressionPolicy.isComplex(expression)

      case .optionalBinding(let binding):
        binding.initializer.map { ExpressionPolicy.bindingIsComplex($0.value) } ?? false

      case .matchingPattern(let pattern): ExpressionPolicy.bindingIsComplex(pattern.initializer.value)

      case .availability: false

      @unknown default: false
      }
    }
    if hasComplexCondition {
      report(keyword)
    }
  }

  private func report(_ token: TokenSyntax) {
    let location = converter.location(for: token.positionAfterSkippingLeadingTrivia)
    diagnostics.append(LintDiagnostic(
      file: file,
      line: location.line,
      character: location.column,
      ruleID: LintDiagnostic.rule,
      reason: LintDiagnostic.message
    ))
  }
}

@main
enum SwiftStyle {
  static func main() {
    do {
      var arguments = Array(CommandLine.arguments.dropFirst())
      let json = arguments.contains("--json")
      arguments.removeAll { $0 == "--json" }
      var selectedRules: Set<String>?
      if let index = arguments.firstIndex(of: "--rules") {
        guard index + 1 < arguments.count else { throw CheckError.invalidArguments }

        let names = Set(arguments[index + 1].split(separator: ",").map(String.init))
        let known = Set(StyleRule.allCases.map(\.rawValue) + [LintDiagnostic.rule])
        guard !names.isEmpty, names.isSubset(of: known) else { throw CheckError.invalidArguments }

        selectedRules = names
        arguments.removeSubrange(index...index + 1)
      }
      var diagnostics: [LintDiagnostic] = []
      if arguments == ["--stdin"] {
        let data = FileHandle.standardInput.readDataToEndOfFile()
        guard let source = String(data: data, encoding: .utf8) else { throw CheckError.invalidUTF8 }

        diagnostics = check(source, file: "<stdin>")
      } else {
        guard arguments.allSatisfy({ !$0.hasPrefix("--") }) else { throw CheckError.invalidArguments }

        let inputs = arguments.isEmpty ? ["."] : arguments
        for file in try files(in: inputs) {
          let source = try String(contentsOf: file, encoding: .utf8)
          diagnostics += check(source, file: file.path)
        }
      }
      if let selectedRules {
        diagnostics = diagnostics.filter { selectedRules.contains($0.ruleID) || $0.ruleID == "swift_parser" }
      }
      if json {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        FileHandle.standardOutput.write(try encoder.encode(diagnostics))
      } else {
        for diagnostic in diagnostics {
          print(diagnostic.output)
        }
      }
      exit(diagnostics.isEmpty ? 0 : 2)
    } catch {
      FileHandle.standardError.write(Data("SwiftStyle: \(error)\n".utf8))
      exit(1)
    }
  }

  /// Parses the file once and stops with a swift_parser diagnostic if syntax errors occur.
  /// Checks interpolated expressions as Swift code. Treats comments and literal text as data.
  private static func check(_ source: String, file: String) -> [LintDiagnostic] {
    let parsed = Parser.parse(source: source)
    let parserDiagnostics = ParseDiagnosticsGenerator.diagnostics(for: parsed)
    let converter = SourceLocationConverter(fileName: file, tree: parsed)
    if !parserDiagnostics.isEmpty {
      return parserDiagnostics.map { diagnostic in
        let location = converter.location(for: diagnostic.position)
        return LintDiagnostic(
          file: file,
          line: location.line,
          character: location.column,
          ruleID: "swift_parser",
          reason: diagnostic.message
        )
      }
    }
    var operators = OperatorTable.standardOperators
    operators.addSourceFile(parsed, errorHandler: { _ in })
    let folded = operators.foldAll(parsed, errorHandler: { _ in })
    let visitor = ConditionVisitor(file: file, tree: parsed)
    visitor.walk(folded)
    let style = StyleVisitor(file: file, source: source, tree: parsed)
    style.walk(folded)
    return (visitor.diagnostics + style.diagnostics).sorted {
      ($0.line, $0.character, $0.ruleID) < ($1.line, $1.character, $1.ruleID)
    }
  }

  private static func files(in inputs: [String]) throws -> [URL] {
    let manager = FileManager.default
    var result = Set<URL>()
    for input in inputs {
      let url = URL(fileURLWithPath: input).standardizedFileURL
      var directory: ObjCBool = false
      guard manager.fileExists(atPath: url.path, isDirectory: &directory) else { throw CheckError.missingInput(input) }

      if !directory.boolValue {
        if url.pathExtension == "swift", !excluded(url) {
          result.insert(url)
        }

        continue
      }
      var readError: (any Error)?
      guard
        let enumerator = manager.enumerator(
          at: url,
          includingPropertiesForKeys: [.isRegularFileKey, .isSymbolicLinkKey],
          errorHandler: { _, error in readError = error; return false }
        )
      else { throw CheckError.missingInput(input) }

      for case let file as URL in enumerator {
        if excluded(file) {
          enumerator.skipDescendants()
          continue
        }

        let values = try file.resourceValues(forKeys: [.isRegularFileKey, .isSymbolicLinkKey])
        if values.isSymbolicLink == true {
          enumerator.skipDescendants()
          continue
        }

        if file.pathExtension == "swift", values.isRegularFile == true {
          result.insert(file.standardizedFileURL)
        }
      }
      if let readError { throw readError }
    }
    return result.sorted { $0.path < $1.path }
  }

  private static func excluded(_ url: URL) -> Bool {
    let directories = Set([
      ".git",
      ".build",
      ".swiftpm",
      "Derived",
      "DerivedData",
      "build",
      "worktrees",
      "Evidence",
      "perf",
    ])
    let path = url.pathComponents.joined(separator: "/")
    if path.contains("/SwiftStyle/Tests/Fixtures") { return true }

    return url.pathComponents.contains { component in
      directories.contains(component) || component.hasSuffix(".xcodeproj") || component.hasSuffix(".xcworkspace")
    }
  }
}

enum CheckError: Error {
  case invalidUTF8

  case invalidArguments

  case missingInput(String)
}

extension CheckError: CustomStringConvertible {
  var description: String {
    switch self {
    case .invalidUTF8: "Input must use UTF-8."

    case .invalidArguments: "Use --json, --stdin, --rules name1,name2, or source paths."

    case .missingInput(let path): "Cannot read input: \(path)"
    }
  }
}
