// MARK: - Input
import Foundation

final class Example: NSObject {
  @available(*, deprecated) @objc(value:) func value(_ input: Int) -> Int { input }

  @available(*, deprecated) @objc @concurrent func compute(_ input: Int) async -> Int { input }
}

// MARK: - Output
import Foundation

final class Example: NSObject {

  @available(*, deprecated)
  @objc(value:) func value(_ input: Int) -> Int { input }

  @available(*, deprecated)
  @objc @concurrent func compute(_ input: Int) async -> Int { input }
}
