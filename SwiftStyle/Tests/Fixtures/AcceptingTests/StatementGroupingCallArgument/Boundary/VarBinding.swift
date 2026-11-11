enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    var next: Int = value + 1
    next += 1
    sink(next)
  }
}
