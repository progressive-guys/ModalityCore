import Foundation
import Testing

@Suite(.serialized)
struct DiagnosticTests {
  @Test(arguments: try FixtureSupport.cases(in: "Diagnostics"))
  func reportsExpectedDiagnostics(_ name: String) throws {
    let fixture = try FixtureSupport.fixture("Diagnostics", name)
    let file = fixture.appendingPathExtension("swift")
    let source = try String(contentsOf: file, encoding: .utf8)
    let structure = FixtureStructure(source)

    #expect(structure.isValid, "\(name): use one enum Accepted and one enum Rejected")

    let sections = FixtureSupport.sectionNames(in: source)
    let expected = try Expectation.load(from: fixture, sections: Set(sections))

    #expect(Set(expected.counts.keys) == ["Accepted", "Rejected"], "\(name)")
    try FixtureSupport.typecheck(file, succeeds: expected.compilerSucceeds)
    #expect(Set(sections.filter { !$0.isEmpty }) == Set(expected.counts.keys), "\(name)")
    for ending in ["\n", "\r\n"] {
      let input = Data(source.replacingOccurrences(of: "\n", with: ending).utf8)
      let result = try FixtureSupport.check(input, rule: expected.rule)
      let diagnostics = try JSONDecoder().decode([Diagnostic].self, from: result.output)
      let expectsDiagnostics = expected.counts.values.contains { $0 != 0 }
      #expect(result.status == (expectsDiagnostics ? 2 : 0), "\(name): \(result.text)")
      #expect(diagnostics.allSatisfy { $0.ruleID == expected.rule && $0.severity == "Error" }, "\(name)")
      let grouped = try Dictionary(grouping: diagnostics) { diagnostic in
        try #require(sections.indices.contains(diagnostic.line - 1))
        let section = sections[diagnostic.line - 1]
        #expect(expected.counts.keys.contains(section), "\(name): \(result.text)")
        return section
      }
      for (section, count) in expected.counts {
        let actualCount = grouped[section, default: []].count
        if let count {
          #expect(actualCount == count, "\(name)/\(section): \(result.text)")
        } else {
          #expect(actualCount > 0, "\(name)/\(section)")
        }
      }

      for (name, count) in expected.caseCounts {
        let lines = try #require(structure.lines(for: name), "Missing fixture case: \(name)")

        #expect(diagnostics.filter { lines.contains($0.line) }.count == count, "\(name): \(result.text)")
      }
    }
  }
}

private struct Expectation {
  let rule: String

  let counts: [String: Int?]

  let caseCounts: [String: Int]

  let compilerSucceeds: Bool

  static func load(from fixture: URL, sections: Set<String>) throws -> Self {
    let file = fixture.appendingPathExtension("json")
    let overrides = if FileManager.default.fileExists(atPath: file.path) {
      try JSONDecoder().decode(Overrides.self, from: Data(contentsOf: file))
    } else {
      Overrides(counts: nil, caseCounts: nil, compilerSucceeds: nil)
    }
    let defaults: [String: Int?] = ["Accepted": 0, "Rejected": 1]
    let counts = defaults.filter { sections.contains($0.key) }
      .merging(overrides.counts ?? [:]) { _, count in count }
    return Self(
      rule: fixture.lastPathComponent,
      counts: counts,
      caseCounts: overrides.caseCounts ?? [:],
      compilerSucceeds: overrides.compilerSucceeds ?? true
    )
  }

  private struct Overrides: Decodable {
    let counts: [String: Int?]?

    let caseCounts: [String: Int]?

    let compilerSucceeds: Bool?
  }
}

private struct Diagnostic: Decodable {
  let ruleID: String
  let severity: String
  let line: Int

  private enum CodingKeys: String, CodingKey {
    case ruleID = "rule_id"
    case severity, line
  }
}
