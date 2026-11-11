// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    guard value > 0 else { return }
    sink(value)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    guard value > 0 else { return }
    sink(value)
  }
}
