enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(abs(value) + input)

    let next = value + 1
    sink(next)
  }
}
