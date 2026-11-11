
enum Example {

  static func pair(_ other: inout Int, _ value: Int) {}

  static func run(input: Int, sink: (Int) -> Void) {
    var other = 0
    let value = input
    pair(&other, value)

    let next = value + 1
    sink(next)
  }
}
