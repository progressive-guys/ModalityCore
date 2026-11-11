// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    // Next calculation.
    let next = abs(value)
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    // Next calculation.
    let next = abs(value)
    sink(next)
  }
}
