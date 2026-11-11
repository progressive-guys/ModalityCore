
enum Example {

  static func visit(_ first: () -> Int, then second: () -> Int) {}

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    visit { 0 } then: { [copy = value] in copy }

    let next = value + 1
    sink(next)
  }
}
