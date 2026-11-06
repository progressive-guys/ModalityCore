enum Examples {

  static func remainingArgument(_ first: Int, _ second: Int) -> [[Int]] {
    Array(repeating: [
      first,
      second
    ], count: 2)
  }
}
