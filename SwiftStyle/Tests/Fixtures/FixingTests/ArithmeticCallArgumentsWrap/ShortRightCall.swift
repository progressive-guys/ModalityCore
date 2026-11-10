// MARK: - Input
enum Example {

  static func sum(_ first: Int, _ second: Int) -> Int {
    first + abs(
      second
    )
  }
}

// MARK: - Output
enum Example {
  static func sum(_ first: Int, _ second: Int) -> Int {
    first + abs(second)
  }
}
