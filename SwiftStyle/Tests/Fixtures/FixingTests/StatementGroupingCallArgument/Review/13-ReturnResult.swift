// MARK: - Input

enum Example {

  static func run(input: Int, other: Int) -> Int {
    let value = input
    let scaled = value * 2
    let count = other
    return scaled + count
  }
}

// MARK: - Output

enum Example {

  static func run(input: Int, other: Int) -> Int {
    let value = input
    let scaled = value * 2

    let count = other

    return scaled + count
  }
}
