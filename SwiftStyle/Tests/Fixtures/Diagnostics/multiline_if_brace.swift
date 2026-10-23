// MARK: - Accepted

enum Accepted {
  static func value(_ first: Bool, _ second: Bool) -> Bool {
    if first,
      second
    { return true }
    return false
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Bool, _ second: Bool) -> Bool {
    if first,
      second { return true }
    return false
  }
}
