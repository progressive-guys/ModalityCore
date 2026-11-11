import Foundation
import SwiftParser
import SwiftSyntax

/// Keeps native checks and accepts the joined closure layout at its syntax lines.
enum ExternalLayoutDiagnostics {

  private struct Diagnostic: Decodable {

    enum CodingKeys: String, CodingKey {
      case file, line, character, reason, severity
      case ruleID = "rule_id"
    }

    let line: Int
    let file: String
    let reason: String
    let ruleID: String
    let character: Int?
    let severity: String?
  }

  private final class Lines: SyntaxVisitor {

    let checker: StyleVisitor

    var joins: Set<Int> = []
    var indentation: Set<Int> = []

    init(checker: StyleVisitor) {
      self.checker = checker
      super.init(viewMode: .sourceAccurate)
    }

    override func visit(_ call: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
      guard checker.joinsChainedClosure(call),
            let member = call.calledExpression.as(MemberAccessExprSyntax.self), let base = member.base,
            checker.layout.endLine(base) == checker.layout.line(member.period),
            let closure = call.trailingClosure, let first = closure.statements.first
      else { return .visitChildren }

      joins.insert(checker.layout.line(member.period))
      if checker.layout.indent(first) == checker.layout.indent(call) + 4,
         checker.layout.indent(closure.rightBrace) == checker.layout.indent(call) + 2
      {
        indentation.insert(checker.layout.line(first))
      }

      return .visitChildren
    }
  }

  static func filter(_ data: Data, status: Int32) throws -> Int32 {
    let diagnostics = try JSONDecoder().decode([Diagnostic].self, from: data)
    if diagnostics.isEmpty { return status }

    var files: [String: Lines] = [:]
    var failed = false

    for diagnostic in diagnostics {
      if ["indentation_width", "multiline_function_chains"].contains(diagnostic.ruleID) {
        if files[diagnostic.file] == nil {
          let source = try String(contentsOfFile: diagnostic.file, encoding: .utf8)
          let tree = Parser.parse(source: source)
          let lines = Lines(checker: StyleVisitor(file: diagnostic.file, source: source, tree: tree))
          lines.walk(tree)

          files[diagnostic.file] = lines
        }

        let lines = files[diagnostic.file]
        let accepted = diagnostic.ruleID == "multiline_function_chains" ? lines?.joins : lines?.indentation
        if accepted?.contains(diagnostic.line) == true { continue }
      }

      let severity = diagnostic.severity?.lowercased() ?? "error"
      print(
        "\(diagnostic.file):\(diagnostic.line):\(diagnostic.character ?? 1): \(severity): \(diagnostic.reason) [\(diagnostic.ruleID)]"
      )
      failed = true
    }
    return failed ? status : 0
  }
}
