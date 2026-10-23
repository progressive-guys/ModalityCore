// MARK: - Accepted

enum Accepted {
  static func value(_ values: [Int]) -> Int {
    values.sorted()
      .dropFirst()
      .count
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ values: [Int]) -> Int {
    values.sorted().dropFirst()
      .count
  }
}
