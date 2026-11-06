// MARK: - Input
enum Examples {
  static func value(_ first: Int, _ second: Int) -> Int {
    first
      +
      second
  }

  static func trailing(_ first: Int, _ second: Int) -> Int {
    first +
      second
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Int, _ second: Int) -> Int {
    first + second
  }

  static func trailing(_ first: Int, _ second: Int) -> Int {
    first + second
  }
}
