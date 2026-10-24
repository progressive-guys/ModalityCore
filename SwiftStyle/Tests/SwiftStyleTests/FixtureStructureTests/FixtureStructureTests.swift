import Foundation
import Testing

final class FixtureStructureTests {
  @Test(arguments: [
    ("Grouped", true),
    ("SplitAccepted", false),
    ("SplitRejected", false),
    ("Duplicate", false),
    ("WrongKind", false),
    ("Nested", false),
    ("Conditional", false)
  ])
  func requiresOneEnumPerGroup(_ name: String, _ valid: Bool) throws {
    let folder = try #require(Bundle(for: Self.self).url(forResource: "Inputs", withExtension: nil))
    let file = folder.appendingPathComponent(name).appendingPathExtension("txt")
    let source = try String(contentsOf: file, encoding: .utf8)

    #expect(FixtureStructure(source).isValid == valid)
  }
}
