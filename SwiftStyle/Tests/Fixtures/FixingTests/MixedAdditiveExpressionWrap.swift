// MARK: - Input
enum Examples {
  static func value(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first +
      second
      - third
  }

  static func partialLeading(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first + second
      - third
  }

  static func partialTrailing(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first + second -
      third
  }

  static func partialEndLeading(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first
      + second - third
  }

  static func partialEndTrailing(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first +
      second - third
  }

  static func trailing(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first +
      second -
      third
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first + second - third
  }

  static func partialLeading(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first + second - third
  }

  static func partialTrailing(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first + second - third
  }

  static func partialEndLeading(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first + second - third
  }

  static func partialEndTrailing(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first + second - third
  }

  static func trailing(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first + second - third
  }
}
