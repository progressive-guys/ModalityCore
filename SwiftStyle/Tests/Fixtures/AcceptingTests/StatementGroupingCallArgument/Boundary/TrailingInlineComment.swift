enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value) // Record this value.

    let next = value + 1
    sink(next)
  }
}
