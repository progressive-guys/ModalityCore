// MARK: - Input
enum Examples {
  static func value(_ first: Int?, _ second: Int?, _ third: Int) -> Int {
    first ?? second
      ?? third
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Int?, _ second: Int?, _ third: Int) -> Int {
    first
      ?? second
      ?? third
  }
}
