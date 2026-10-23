// MARK: - Accepted

enum Accepted {
  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    first
      && second
      || third
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    first && second
      || third
  }
}
