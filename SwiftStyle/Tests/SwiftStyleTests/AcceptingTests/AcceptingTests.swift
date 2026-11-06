import Testing
import Foundation
import ModalityCore

@Suite(.serialized)
struct AcceptingTests {

  @Test(arguments: try Files.AcceptingTests.files)
  func keepsValidSource(_ resource: BundledResource<SwiftFixture>) throws {
    let fixture = try resource.load()
    for source in fixture.sources() {
      try FixtureSupport.typecheck(source, name: fixture.name)

      let diagnostics = try FixtureSupport.check(source)
      let fixed = try FixtureSupport.check(source, fix: true)
      #expect(diagnostics.status == 0, "\(diagnostics.text)")
      #expect(try JSONDecoder().decode([Diagnostic].self, from: diagnostics.output).isEmpty)
      #expect(fixed.status == 0, "\(fixed.text)")
      #expect(fixed.errors.isEmpty)
      #expect(fixed.output == source, "\(fixture.name):\n\(fixed.text)")
    }
  }
}
