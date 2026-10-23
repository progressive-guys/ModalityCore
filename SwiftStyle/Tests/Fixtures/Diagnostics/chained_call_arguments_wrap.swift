// MARK: - Accepted

enum Accepted {
  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted()
      .contains(
        value
      )
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted().contains(
      value
    )
  }
}
