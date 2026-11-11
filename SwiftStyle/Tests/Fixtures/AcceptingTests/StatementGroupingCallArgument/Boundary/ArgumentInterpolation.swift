enum Example {

  static func run(input: Int, say: (String) -> Void, sink: (Int) -> Void) {
    let value = input
    say("\(value)")

    let next = value + 1
    sink(next)
  }
}
