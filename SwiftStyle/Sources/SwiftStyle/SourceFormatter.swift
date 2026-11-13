/// Defines the formatter entry point for the replacement engine.
enum SourceFormatter {
  static func format(_ source: String, file: String, rules: Set<String>?) throws -> String {
    throw CheckError.notImplemented
  }
}
