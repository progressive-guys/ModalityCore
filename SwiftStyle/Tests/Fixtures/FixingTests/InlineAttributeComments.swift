// MARK: - Input
import Foundation

final class Example: NSObject {
  @available(*, deprecated) @objc // Called through Objective-C.
  func value() -> Int { 0 }
}

// MARK: - Output
import Foundation

final class Example: NSObject {
  @available(*, deprecated)
  @objc // Called through Objective-C.
  func value() -> Int { 0 }
}
