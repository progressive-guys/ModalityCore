// MARK: - Accepted

enum Accepted {
  static func value(_ first: Int, _ expectedFirst: Int,
    _ second: Int, _ expectedSecond: Int) -> Bool {
    guard
      max(abs(first), abs(second)) == max(abs(expectedFirst), abs(expectedSecond)),
      min(abs(first), abs(second)) == min(abs(expectedFirst), abs(expectedSecond))
    else { return false }

    return true
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Int, _ expectedFirst: Int,
    _ second: Int, _ expectedSecond: Int) -> Bool {
    guard max(abs(first), abs(second)) == max(abs(expectedFirst), abs(expectedSecond)),
      min(abs(first), abs(second)) == min(abs(expectedFirst), abs(expectedSecond))
    else { return false }

    return true
  }
}
