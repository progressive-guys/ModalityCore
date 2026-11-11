enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    let next = { [copy = value] in copy + 1 }
    sink(next())
  }
}
