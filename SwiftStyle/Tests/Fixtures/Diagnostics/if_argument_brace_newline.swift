// MARK: - Accepted

enum Accepted {
  static func value(_ values: [Int], _ value: Int) -> Bool {
    if values.contains(
      value
    ) { return true }
    return false
  }

  static func arrayLiteral(_ value: String) -> Bool {
    if [
      "first", "second"
    ].contains(value)
    { return true }
    return false
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ values: [Int], _ value: Int) -> Bool {
    if values.contains(
      value
    )
    { return true }
    return false
  }
}
