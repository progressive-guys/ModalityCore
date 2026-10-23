// MARK: - Accepted

enum Accepted {
  static func value(_ first: Int, _ second: Int) -> Int {
    first
      + second
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Int, _ second: Int) -> Int {
    first +
      second
  }
}
