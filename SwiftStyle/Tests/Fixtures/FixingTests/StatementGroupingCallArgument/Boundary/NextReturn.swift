// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) -> Int {
    let value = input
    let copy = value + 1
    sink(copy)

    return abs(copy)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) -> Int {
    let value = input
    let copy = value + 1
    sink(copy)
    return abs(copy)
  }
}
