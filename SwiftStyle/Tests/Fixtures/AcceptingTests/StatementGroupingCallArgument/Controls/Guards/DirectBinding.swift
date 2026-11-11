
enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let value = input
    guard value > 0 else { return }
    sink(value)
    sink(other)
  }
}
