// MARK: - Input
enum Examples {
  static func value(_ first: Int?, _ second: (value: Int, other: Bool)) -> Int {
    first ??
      second.value
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Int?, _ second: (value: Int, other: Bool)) -> Int {
    first
      ?? second.value
  }
}
