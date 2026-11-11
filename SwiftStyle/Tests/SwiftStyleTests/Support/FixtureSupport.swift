import Testing
import Foundation

/// Runs the checker and compiler for fixture sources.
enum FixtureSupport {

  /// Resolves the active Xcode's syntax libraries, testing frameworks and expectation macros.
  private static let typecheckArguments = Result {
    let compiler = try run("/usr/bin/xcrun", ["--find", "swiftc"])
    try #require(compiler.status == 0, "\(compiler.text)")
    let host = URL(fileURLWithPath: compiler.text.trimmingCharacters(in: .whitespacesAndNewlines))
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("lib/swift/host")

    let platform = try run("/usr/bin/xcrun", ["--sdk", "macosx", "--show-sdk-platform-path"])
    try #require(platform.status == 0, "\(platform.text)")
    let developer = URL(fileURLWithPath: platform.text.trimmingCharacters(in: .whitespacesAndNewlines))
      .appendingPathComponent("Developer")

    return [
      "swiftc",
      "-swift-version",
      "6",
      "-I",
      host.path,
      "-F",
      developer.appendingPathComponent("Library/Frameworks").path,
      "-I",
      developer.appendingPathComponent("usr/lib").path,
      "-plugin-path",
      host.appendingPathComponent("plugins/testing").path,
      "-typecheck",
      "-"
    ]
  }

  static func typecheck(_ source: Data, name: String) throws {
    let result = try run("/usr/bin/xcrun", typecheckArguments.get(), input: source)
    #expect(result.status == 0, "\(name): \(result.text)")
  }

  static func check(_ source: Data, fix: Bool = false, rules: [String] = []) throws -> ProcessResult {
    let executable = Bundle.module.bundleURL
      .deletingLastPathComponent()
      .appendingPathComponent("SwiftStyle")

    let arguments = (fix ? ["--fix", "--stdin"] : ["--json", "--stdin"])
      + (rules.isEmpty ? [] : ["--rules", rules.joined(separator: ",")])

    return try run(executable.path, arguments, input: source)
  }

  /// Checks the joined closure and argument threshold through two complete build-format passes.
  static func checkBuild(_ fixture: SwiftFixture, expected: String) throws {
    let source = Data(fixture.source.utf8)
    let target = Data(expected.utf8)
    try typecheck(source, name: fixture.name)

    let file = FileManager.default.temporaryDirectory.appendingPathComponent("SwiftStyle-\(UUID().uuidString).swift")

    try source.write(to: file, options: .withoutOverwriting)
    defer { _ = try? run("/usr/bin/trash", [file.path]) }

    let kit = URL(fileURLWithPath: #filePath)
      .deletingLastPathComponent()
      .appendingPathComponent("../../..")
      .standardizedFileURL

    for _ in 0..<2 {
      let result = try run(
        "/usr/bin/env",
        ["CI=false", "/bin/sh", kit.appendingPathComponent("Scripts/lint.sh").path, "--fix", file.path]
      )

      let actual = try Data(contentsOf: file)

      #expect(result.status == 0, "\(result.text)")
      #expect(actual == target, "\(fixture.name):\n\(String(decoding: actual, as: UTF8.self))")
    }
    try typecheck(target, name: fixture.name)
  }

  /// Drains both output streams while the child runs, including while stdin is written.
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

    let stdin = Pipe()
    let stdout = Pipe()
    let stderr = Pipe()

    process.standardInput = stdin
    process.standardOutput = stdout
    process.standardError = stderr
    try process.run()

    let output = ProcessOutput()
    let errors = ProcessOutput()
    let readers = DispatchGroup()
    readers.enter()

    DispatchQueue.global().async {
      output.read(stdout.fileHandleForReading)
      readers.leave()
    }
    readers.enter()

    DispatchQueue.global().async {
      errors.read(stderr.fileHandleForReading)
      readers.leave()
    }

    if let input { try stdin.fileHandleForWriting.write(contentsOf: input) }
    try stdin.fileHandleForWriting.close()

    process.waitUntilExit()

    readers.wait()

    return ProcessResult(output: output.data, errors: errors.data, status: process.terminationStatus)
  }
}

struct ProcessResult {

  let output: Data
  let errors: Data
  let status: Int32

  var text: String { String(decoding: output + errors, as: UTF8.self) }
}

/// Protects data passed from a pipe reader to the calling test.
private final class ProcessOutput: @unchecked Sendable {

  private let lock = NSLock()

  private var bytes = Data()

  var data: Data { lock.withLock { bytes } }

  func read(_ handle: FileHandle) {
    let data = handle.readDataToEndOfFile()
    lock.withLock { bytes = data }
  }
}
