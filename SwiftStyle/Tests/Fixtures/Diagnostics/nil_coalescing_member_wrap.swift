// MARK: - Accepted

enum Accepted {
  static func value(_ first: Int?, _ second: (value: Int, other: Bool)) -> Int {
    first
      ?? second.value
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Int?, _ second: (value: Int, other: Bool)) -> Int {
    first ??
      second.value
  }
}
