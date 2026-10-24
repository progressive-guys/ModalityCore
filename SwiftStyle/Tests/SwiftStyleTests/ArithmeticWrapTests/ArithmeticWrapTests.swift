import Foundation
import Testing

struct ArithmeticWrapTests {
  @Test(arguments: ["arithmetic_precedence_wrap", "arithmetic_call_arguments_wrap"])
  func arithmeticRulesAcceptTheSameLayout(_ name: String) throws {
    let fixture = try FixtureSupport.fixture("Diagnostics", name)
      .appendingPathExtension("swift")
    let source = try String(contentsOf: fixture, encoding: .utf8)
    let rejected = try #require(source.range(of: "// MARK: - Rejected"))
    let accepted = Data(source[..<rejected.lowerBound].utf8)
    let rules = [
      "arithmetic_precedence_wrap",
      "binary_operator_wrap",
      "multiline_expression_closing_delimiter",
      "mixed_additive_expression_wrap",
      "mixed_multiplicative_expression_wrap",
      "arithmetic_member_wrap",
      "arithmetic_call_arguments_wrap",
      "binary_operand_member_wrap"
    ]
    let result = try FixtureSupport.check(accepted, rule: rules.joined(separator: ","))
    let diagnostics = try JSONDecoder().decode([AcceptedDiagnostic].self, from: result.output)
    #expect(result.status == 0, "\(result.text)")
    #expect(diagnostics.isEmpty, "\(result.text)")
  }
}

private struct AcceptedDiagnostic: Decodable {}
