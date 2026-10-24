// MARK: - Accepted

enum Accepted {
  static func value(_ first: Int, _ expectedFirst: Int,
    _ second: Int, _ expectedSecond: Int) -> Bool {
    guard
      first == expectedFirst,
      second == expectedSecond
    else { return false }

    return true
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Int, _ expectedFirst: Int,
    _ second: Int, _ expectedSecond: Int) -> Bool {
    guard first == expectedFirst,
      second == expectedSecond
    else { return false }

    return true
  }
}
