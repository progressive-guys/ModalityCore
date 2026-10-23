// MARK: - Accepted

enum Accepted {
  static func value(_ source: Any) -> Int? {
    source as? Int
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ source: Any) -> Int? {
    source
      as? Int
  }
}
