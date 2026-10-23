// MARK: - Accepted

enum Accepted {
  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    if first,
      second,
      third
    { return true }
    return false
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    if first, second,
      third { return true }
    return false
  }
}
