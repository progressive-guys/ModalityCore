
enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let (first, second) = (input, other)
    let doubled = first * 2
    let count = second + 1
    sink(doubled + count)
  }
}
