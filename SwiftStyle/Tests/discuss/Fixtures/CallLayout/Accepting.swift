// MARK: - Case ThreeArgumentCallWithGap
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

// MARK: - Case TwoArgumentCallWithGap
enum Examples {

  static func value() -> String {
    let value = String(
      repeating: "a",
      count: 2
    )

    return value
  }
}

// MARK: - Case TwoArgumentCallWithoutGap
enum Examples {

  static func value() -> String {
    let value = String(
      repeating: "a",
      count: 2
    )
    return value
  }
}
