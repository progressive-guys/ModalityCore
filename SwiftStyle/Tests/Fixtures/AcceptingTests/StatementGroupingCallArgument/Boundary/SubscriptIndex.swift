enum Example {

  static func run(input: Int, list: [Int], sink: (Int) -> Void) {
    let value = input
    sink(list[value])

    let next = value + 1
    sink(next)
  }
}
