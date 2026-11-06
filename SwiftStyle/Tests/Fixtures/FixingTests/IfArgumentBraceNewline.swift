// MARK: - Input
enum Examples {
  static func value(_ values: [Int], _ value: Int) -> Bool {
    if values.contains(
      value
    )
    { return true }
    return false
  }
}

// MARK: - Output
enum Examples {

  static func value(_ values: [Int], _ value: Int) -> Bool {
    if values.contains(
      value
    ) { return true }

    return false
  }
}
