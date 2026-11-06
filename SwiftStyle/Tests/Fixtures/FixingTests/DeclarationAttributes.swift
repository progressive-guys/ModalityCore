// MARK: - Input
@preconcurrency
import Foundation

@MainActor @available(*, deprecated) final class Example {
  @available(*, deprecated) init() {}

  @available(*, deprecated) var value: Int { 0 }

  @available(*, deprecated) func action(_ body: @escaping @Sendable () -> Void) -> @Sendable () -> Void {
    body
  }
}

// MARK: - Output
@preconcurrency import Foundation

@MainActor
@available(*, deprecated)
final class Example {

  @available(*, deprecated)
  init() {}

  @available(*, deprecated)
  var value: Int { 0 }

  @available(*, deprecated)
  func action(_ body: @escaping @Sendable () -> Void) -> @Sendable () -> Void {
    body
  }
}
