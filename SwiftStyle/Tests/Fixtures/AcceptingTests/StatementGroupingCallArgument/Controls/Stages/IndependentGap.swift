
enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let value = input + 1
    sink(value)

    let next = other + 1
    sink(next)
  }
}
