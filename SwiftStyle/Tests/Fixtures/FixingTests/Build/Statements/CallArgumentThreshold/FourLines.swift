// MARK: - Input
import Foundation

enum Examples {

  static func value() -> String {
    let value = "a".replacingOccurrences(
      of: "a",
      with: "b",
      options: .literal,
      range: nil
    )
    return value
  }
}

// MARK: - Output
import Foundation

enum Examples {

  static func value() -> String {
    let value = "a".replacingOccurrences(
      of: "a",
      with: "b",
      options: .literal,
      range: nil
    )

    return value
  }
}
