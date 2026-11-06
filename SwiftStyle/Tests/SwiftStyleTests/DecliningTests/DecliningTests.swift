import Testing
import Foundation
import ModalityCore

@Suite(.serialized)
struct DecliningTests {

  private static let expectedRules: [String: Set<String>] = [
    "Conditions": ["complex_control_flow_condition"],
    "ElseIfCondition": ["complex_control_flow_condition"],
    "ImplicitResultCondition": ["complex_control_flow_condition"],
    "BindingCondition": ["complex_control_flow_condition"],
    "WhereCondition": ["complex_control_flow_condition"],
    "MacroCondition": ["complex_control_flow_condition"],
    "LabeledCondition": ["complex_control_flow_condition"],
    "GlobalFunctions": ["no_global_functions"],
    "ParserError": ["swift_parser"],
    "WrappedProperties": ["property_grouping"],
    "MultilineInterpolation": ["multiline_string_indent"],
    "UnknownViewWrapper": ["private_view_properties"],
    "RepeatedCalls": ["complex_control_flow_condition"]
  ]

  @Test(arguments: try Files.DecliningTests.files)
  func retainsUnresolvedViolation(_ resource: BundledResource<SwiftFixture>) throws {
    let fixture = try resource.load()
    for source in fixture.sources() {
      let result = try FixtureSupport.check(source)
      let diagnostics = try JSONDecoder().decode([Diagnostic].self, from: result.output)
      let fixed = try FixtureSupport.check(source, fix: true)
      let repeated = try FixtureSupport.check(fixed.output)
      #expect(result.status == 2, "\(result.text)")
      #expect(!diagnostics.isEmpty)

      let expected = try #require(Self.expectedRules[fixture.name])

      #expect(Set(diagnostics.map(\.ruleID)) == expected)
      if !expected.contains("swift_parser") { try FixtureSupport.typecheck(source, name: fixture.name) }

      #expect(fixed.status == 2, "\(fixed.text)")
      #expect(fixed.output == source, "\(fixture.name):\n\(fixed.text)")
      #expect(!fixed.errors.isEmpty)

      #expect(repeated.output == result.output)
    }
  }
}

/// Reads the diagnostic identity without fixing its count or source position.
struct Diagnostic: Decodable {

  enum CodingKeys: String, CodingKey {
    case ruleID = "rule_id"
  }

  let ruleID: String
}
