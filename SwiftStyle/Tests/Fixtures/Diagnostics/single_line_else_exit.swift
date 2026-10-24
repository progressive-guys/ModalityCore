// MARK: - Accepted

enum Accepted {
  static func value(_ first: Bool) -> Void {
    if first { return } else {
      print("value")
    }
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Bool) -> Void {
    if first { return } else { print("value") }
  }
}
