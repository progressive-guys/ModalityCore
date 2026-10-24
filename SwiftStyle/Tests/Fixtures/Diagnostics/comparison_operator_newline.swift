// MARK: - Accepted

enum Accepted {
  static func value(_ first: Int, _ second: Int) -> Bool {
    first == second
  }

  static func leading(_ first: Int, _ second: Int) -> Bool {
    first
      == second
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Int, _ second: Int) -> Bool {
    first ==
      second
  }
}
