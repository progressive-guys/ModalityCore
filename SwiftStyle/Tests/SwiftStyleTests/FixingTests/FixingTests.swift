import Testing
import Foundation
import ModalityCore

@Suite(.serialized)
struct FixingTests {

  @Test(arguments: try Files.FixingTests.files)
  func matchesExpectedOutput(_ resource: BundledResource<SwiftFixture>) throws {
    let fixture = try resource.loadFixing()
    let expected = fixture.output.source
    for source in fixture.input.sources() {
      let newline = source.contains(13) ? "\r\n" : "\n"
      let result = try FixtureSupport.check(source, fix: true)
      let target = Data(expected.replacingOccurrences(of: "\n", with: newline).utf8)
      #expect(result.status == 0, "\(result.text)")
      #expect(result.errors.isEmpty)
      #expect(result.output == target, "\(fixture.input.name):\n\(result.text)")

      try FixtureSupport.typecheck(source, name: fixture.input.name)

      try FixtureSupport.typecheck(target, name: fixture.output.name)
      let diagnostics = try FixtureSupport.check(target)
      let repeated = try FixtureSupport.check(target, fix: true)
      #expect(diagnostics.status == 0, "\(diagnostics.text)")
      #expect(try JSONDecoder().decode([Diagnostic].self, from: diagnostics.output).isEmpty)
      #expect(repeated.output == target, "\(fixture.output.name):\n\(repeated.text)")
      #expect(repeated.status == 0, "\(repeated.text)")
      #expect(repeated.errors.isEmpty)
    }
  }
}
