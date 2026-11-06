// MARK: - Input
enum Examples {
  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted().contains(
      value
    )
  }
}

// MARK: - Output
enum Examples {

  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted()
      .contains(
      value
    )
  }
}
