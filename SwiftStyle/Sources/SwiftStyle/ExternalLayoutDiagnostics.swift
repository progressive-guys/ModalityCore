import Foundation

/// Defines the native diagnostic adapter entry point.
enum ExternalLayoutDiagnostics {
  static func filter(_ data: Data, status: Int32) throws -> Int32 {
    throw CheckError.notImplemented
  }
}
