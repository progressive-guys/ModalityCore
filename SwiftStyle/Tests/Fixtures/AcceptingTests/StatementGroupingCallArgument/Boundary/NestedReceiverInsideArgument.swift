enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value.distance(to: input))

    let next = value + 1
    sink(next)
  }
}
