
enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let first = input
    let second = other
    let sum = first + second
    sink(sum)
  }
}
