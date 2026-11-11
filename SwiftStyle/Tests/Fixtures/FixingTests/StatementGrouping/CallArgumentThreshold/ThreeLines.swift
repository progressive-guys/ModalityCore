// MARK: - Input
import Foundation

enum Examples {

  static func value() -> String {
    let value = "a".replacingOccurrences(
      of: "a",
      // Comments and blank lines are excluded.

      with: "b",
      // The third code line contains the last argument.
      options: .literal
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
      // Comments and blank lines are excluded.

      with: "b",
      // The third code line contains the last argument.
      options: .literal
    )

    return value
  }
}
