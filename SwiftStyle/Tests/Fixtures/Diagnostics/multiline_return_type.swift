// MARK: - Accepted

enum Accepted {
  static func value() -> (Int, Int) { (1, 2) }
}

// MARK: - Rejected

enum Rejected {
  static func value() -> (
    Int, Int
  ) { (1, 2) }
}
