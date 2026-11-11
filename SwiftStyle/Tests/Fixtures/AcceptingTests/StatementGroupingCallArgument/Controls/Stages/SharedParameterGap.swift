
enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    sink(input)
    sink(other)

    let value = input + other
    sink(value)
  }
}
