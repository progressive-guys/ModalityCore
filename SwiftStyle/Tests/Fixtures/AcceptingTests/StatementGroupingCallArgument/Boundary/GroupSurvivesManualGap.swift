enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    let next = abs(value)
    let sum = next + value
    sink(sum)
  }
}
