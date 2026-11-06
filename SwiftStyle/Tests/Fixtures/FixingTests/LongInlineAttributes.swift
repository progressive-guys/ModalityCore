// MARK: - Input
import Foundation

final class ObjectiveCExample: NSObject {
  @objc(exportValueForConfiguredProjects:defaultValue:) func export(_ projectIdentifier: String, defaultValue: String) {}
}

final class ConcurrentExample {
  @concurrent func calculateValues(_ first: Int, second: Int, third: Int, fourth: Int, fifth: Int) async -> Int { first }
}

// MARK: - Output
import Foundation

final class ObjectiveCExample: NSObject {
  @objc(exportValueForConfiguredProjects:defaultValue:)
  func export(_ projectIdentifier: String, defaultValue: String) {}
}

final class ConcurrentExample {
  @concurrent
  func calculateValues(_ first: Int, second: Int, third: Int, fourth: Int, fifth: Int) async -> Int { first }
}
