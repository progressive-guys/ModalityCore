// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = sink
    value(input)

    let next = value
    next(input)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = sink
    value(input)
    let next = value
    next(input)
  }
}
