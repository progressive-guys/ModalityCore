// MARK: - Accepted

enum Accepted {
  static func value(_ first: Int, _ second: Int) -> Bool {
    first == second
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Int, _ second: Int) -> Bool {
    first
      == second
  }
}
