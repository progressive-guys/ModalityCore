// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let first = input
    sink(first)

    let second = input + 1
    sink(second)
    let next = second + first
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let first = input
    sink(first)

    let second = input + 1
    sink(second)

    let next = second + first
    sink(next)
  }
}
