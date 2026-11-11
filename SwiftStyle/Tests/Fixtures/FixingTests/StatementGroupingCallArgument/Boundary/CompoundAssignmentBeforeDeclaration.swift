// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    var value = 0
    value += input

    let next = value + 1
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    var value = 0
    value += input
    let next = value + 1
    sink(next)
  }
}
