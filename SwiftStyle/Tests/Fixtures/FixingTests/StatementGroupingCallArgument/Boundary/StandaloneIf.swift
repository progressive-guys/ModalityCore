// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    if value > 0 {
      sink(value)
    }

    sink(input)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    if value > 0 {
      sink(value)
    }

    sink(input)
  }
}
