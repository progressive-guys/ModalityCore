import Testing
import Foundation

/// Runs the checker and compiler for fixture sources.
enum FixtureSupport {

  static func typecheck(_ source: Data, name: String) throws {
    let compiler = try run("/usr/bin/xcrun", ["--find", "swiftc"])
    try #require(compiler.status == 0, "\(compiler.text)")
    let host = URL(fileURLWithPath: compiler.text.trimmingCharacters(in: .whitespacesAndNewlines))
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("lib/swift/host")
    let arguments = ["swiftc", "-swift-version", "6", "-I", host.path, "-typecheck", "-"]
    let result = try run("/usr/bin/xcrun", arguments, input: source)
    #expect(result.status == 0, "\(name): \(result.text)")
  }

  static func check(_ source: Data, fix: Bool = false) throws -> ProcessResult {
    let executable = Bundle.module.bundleURL
      .deletingLastPathComponent()
      .appendingPathComponent("SwiftStyle")
    return try run(executable.path, fix ? ["--fix", "--stdin"] : ["--json", "--stdin"], input: source)
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
