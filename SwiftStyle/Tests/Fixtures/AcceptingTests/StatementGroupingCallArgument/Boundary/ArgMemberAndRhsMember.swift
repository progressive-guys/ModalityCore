enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = (first: input, second: input)
    sink(value.first)

    let next = value.second
    sink(next)
  }
}
