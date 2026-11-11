enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let preceding = input
    sink(preceding)
    sink(input)

    let next = input + 1
    sink(next)
  }
}
