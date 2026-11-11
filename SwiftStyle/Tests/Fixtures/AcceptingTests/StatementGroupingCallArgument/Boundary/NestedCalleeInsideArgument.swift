enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value: (Int) -> Int = abs
    sink(value(input))

    let next = value(input + 1)
    sink(next)
  }
}
