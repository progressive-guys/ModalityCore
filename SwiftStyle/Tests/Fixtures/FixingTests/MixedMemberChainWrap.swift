// MARK: - Input
enum Examples {
  static func value(_ values: [Int]) -> Int {
    values.sorted().dropFirst()
      .count
  }
}

// MARK: - Output
enum Examples {

  static func value(_ values: [Int]) -> Int {
    values.sorted()
      .dropFirst()
      .count
  }
}
