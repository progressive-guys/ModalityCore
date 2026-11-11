// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    let other = input + 2
    sink(other)

    let next = value + 1
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    let other = input + 2
    sink(other)
    let next = value + 1
    sink(next)
  }
}
