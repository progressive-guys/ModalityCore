
enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    var value = input
    value += 1
    guard value > 0 else { return }
    sink(value)
  }
}
