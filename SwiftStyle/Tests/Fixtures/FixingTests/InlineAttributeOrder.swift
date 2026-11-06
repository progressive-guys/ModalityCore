// MARK: - Input
import Foundation

final class Example: NSObject {
  @objc @available(*, deprecated) func value() -> Int { 0 }
}

// MARK: - Output
import Foundation

final class Example: NSObject {
  @objc
  @available(*, deprecated)
  func value() -> Int { 0 }
}
