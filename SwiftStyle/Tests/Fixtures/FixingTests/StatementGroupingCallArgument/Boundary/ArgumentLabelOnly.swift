// MARK: - Input

enum Example {

  static func log(value: Int) {}

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    let other = input
    log(value: other)

    let next = value + 1
    sink(next)
  }
}

// MARK: - Output

enum Example {

  static func log(value: Int) {}

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    let other = input
    log(value: other)
    let next = value + 1
    sink(next)
  }
}
