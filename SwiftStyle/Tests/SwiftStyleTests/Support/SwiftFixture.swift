import Testing
import Foundation
import ModalityCore

/// Holds source text read from a Swift fixture.
struct SwiftFixture: Sendable, CustomTestStringConvertible {

  let name: String
  let source: String

  var testDescription: String { name }

  /// Tests both supported line endings with the same independent expectation.
  func sources() -> [Data] {
    [Data(source.utf8), Data(source.replacingOccurrences(of: "\n", with: "\r\n").utf8)]
  }
}

/// Stores the input and its independently authored expected output.
struct FixingSwiftFixture: Sendable, CustomTestStringConvertible {
  let input: SwiftFixture
  let output: SwiftFixture

  var testDescription: String { input.name }
}

/// Reads Swift source and independently authored fix sections.
extension BundledResource where Content == SwiftFixture {

  func load() throws -> SwiftFixture {
    // Bundle paths use Fixtures/<Suite>/<Scenario>.swift.
    let scenario = path.split(separator: "/").dropFirst(2).joined(separator: "/")
    return SwiftFixture(
      name: (scenario as NSString).deletingPathExtension,
      source: try String(contentsOf: url, encoding: .utf8).replacingOccurrences(of: "\r\n", with: "\n")
    )
  }

  func loadFixing() throws -> FixingSwiftFixture {
    let fixture = try load()
    let header = "// MARK: - Input\n"
    let parts = fixture.source.components(separatedBy: "\n// MARK: - Output\n")
    guard fixture.source.hasPrefix(header), parts.count == 2 else {
      throw CocoaError(.fileReadCorruptFile, userInfo: [NSFilePathErrorKey: path])
    }
    return FixingSwiftFixture(
      input: SwiftFixture(name: fixture.name, source: String(parts[0].dropFirst(header.count))),
      output: SwiftFixture(name: fixture.name + "/Output", source: parts[1])
    )
  }
}
