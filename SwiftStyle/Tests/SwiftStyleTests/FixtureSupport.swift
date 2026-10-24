import Foundation
import Testing

enum FixtureSupport {
  static var root: URL {
    get throws {
      try #require(Bundle(for: FixtureBundle.self).url(forResource: "Fixtures", withExtension: nil))
    }
  }

  static func cases(in group: String) throws -> [String] {
    let folder = try root.appendingPathComponent(group)
    return try FileManager.default
      .contentsOfDirectory(atPath: folder.path)
      .filter { $0.hasSuffix(".swift") }
      .map { String($0.dropLast(".swift".count)) }
      .sorted()
  }

  static func fixture(_ group: String, _ name: String) throws -> URL {
    try root.appendingPathComponent(group).appendingPathComponent(name)
  }

  static func sectionNames(in source: String) -> [String] {
    let marker = "// MARK: - "
    var name = ""
    return source.components(separatedBy: "\n").map { line in
      if line.hasPrefix(marker) {
        name = String(line.dropFirst(marker.count))
      }
      return name
    }
  }

  static func typecheck(_ file: URL, succeeds: Bool = true) throws {
    let compiler = try run("/usr/bin/xcrun", ["--find", "swiftc"])
    let host = URL(fileURLWithPath: compiler.text.trimmingCharacters(in: .whitespacesAndNewlines))
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("lib/swift/host")
    let arguments = ["swiftc", "-swift-version", "6", "-I", host.path, "-typecheck", file.path]
    let result = try run("/usr/bin/xcrun", arguments)
    #expect((result.status == 0) == succeeds, "\(file.path): \(result.text)")
  }

  static func check(_ source: Data, rule: String) throws -> ProcessResult {
    let executable = Bundle(for: FixtureBundle.self).bundleURL
      .deletingLastPathComponent()
      .appendingPathComponent("SwiftStyle")
    var arguments = ["--json", "--stdin"]
    if rule != "swift_parser" {
      arguments.append(contentsOf: ["--rules", rule])
    }
    return try run(executable.path, arguments, input: source)
  }

  private static func run(
    _ executable: String,
    _ arguments: [String],
    input: Data? = nil
  ) throws -> ProcessResult {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: executable)
    process.arguments = arguments
    var environment = ProcessInfo.processInfo.environment
    environment["SDKROOT"] = nil
    process.environment = environment
    let output = Pipe()
    let stdin = Pipe()
    process.standardInput = stdin
    process.standardOutput = output
    process.standardError = output
    try process.run()
    if let input {
      try stdin.fileHandleForWriting.write(contentsOf: input)
    }
    try stdin.fileHandleForWriting.close()
    let data = output.fileHandleForReading.readDataToEndOfFile()
    process.waitUntilExit()
    return ProcessResult(status: process.terminationStatus, output: data)
  }
}

struct ProcessResult {
  let status: Int32
  let output: Data

  var text: String { String(decoding: output, as: UTF8.self) }
}

private final class FixtureBundle: NSObject {}
