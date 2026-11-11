// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    let next: Int
    next = input
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    let next: Int
    next = input
    sink(next)
  }
}
