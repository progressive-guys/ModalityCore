import Foundation

enum Examples {

  static func value() -> String {
    let value = "a".replacingOccurrences(
      of: "a",
      with: "b",
      options: .literal
    )

    return value
  }
}
