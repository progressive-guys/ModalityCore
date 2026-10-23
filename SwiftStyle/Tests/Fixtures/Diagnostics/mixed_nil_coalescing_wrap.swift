// MARK: - Accepted

enum Accepted {
  static func value(_ first: Int?, _ second: Int?, _ third: Int) -> Int {
    first
      ?? second
      ?? third
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Int?, _ second: Int?, _ third: Int) -> Int {
    first ?? second
      ?? third
  }
}
