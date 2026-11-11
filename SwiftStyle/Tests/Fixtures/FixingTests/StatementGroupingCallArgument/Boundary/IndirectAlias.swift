// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    let alias = value
    sink(alias)

    let next = abs(value)
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    let alias = value
    sink(alias)
    let next = abs(value)
    sink(next)
  }
}
