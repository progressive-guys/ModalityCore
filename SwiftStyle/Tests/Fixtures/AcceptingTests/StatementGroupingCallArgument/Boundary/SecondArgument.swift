
enum Example {

  static func pair(_ lhs: Int, _ rhs: Int) {}

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    pair(input, value)

    let next = value + 1
    sink(next)
  }
}
