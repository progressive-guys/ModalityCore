enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    let next: Int = value + 1
    sink(next)
  }
}
