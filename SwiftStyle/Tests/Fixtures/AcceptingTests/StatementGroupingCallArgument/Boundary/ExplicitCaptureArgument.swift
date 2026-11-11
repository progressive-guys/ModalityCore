enum Example {

  static func run(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
    let value = input
    visit { [copy = value] in copy }

    let next = value + 1
    sink(next)
  }
}
