import Foundation
import SwiftParser
import SwiftSyntax

/// Keeps native checks and applies the accepted chained-list exception at exact syntax lines.
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
    var closureIndentation: Set<Int> = []

    init(checker: StyleVisitor) {
      self.checker = checker
      super.init(viewMode: .sourceAccurate)
    }

    override func visit(_ call: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
      closureIndentation.formUnion(checker.checkChainedClosureIndent(call))

      if checker.hasJoinedListLayout(call),
         let member = call.calledExpression.as(MemberAccessExprSyntax.self), let closing = call.rightParen
      {
        joins.insert(checker.layout.line(member.period))

        guard let opening = call.leftParen, checker.layout.line(opening) != checker.layout.line(closing)
        else { return .visitChildren }

        indentation.insert(checker.layout.line(closing))

        for argument in call.arguments {
          if let token = argument.firstToken(viewMode: .sourceAccurate) {
            indentation.insert(checker.layout.line(token))
          }
        }
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
      if ["wrapArguments", "indentation_width", "multiline_function_chains"].contains(diagnostic.ruleID) {
        if files[diagnostic.file] == nil {
          let source = try String(contentsOfFile: diagnostic.file, encoding: .utf8)
          let tree = Parser.parse(source: source)
          let lines = Lines(checker: StyleVisitor(file: diagnostic.file, source: source, tree: tree))
          lines.walk(tree)

          files[diagnostic.file] = lines
        }

        let lines = files[diagnostic.file]
        if diagnostic.ruleID == "indentation_width", lines?.closureIndentation.contains(diagnostic.line) == true {
          continue
        }
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
