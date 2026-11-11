// MARK: - Input
enum Example {

  static func run(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
    let value = input
    let other = input
    visit { [copy = other] in copy + value }

    let next = value + 1
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
    let value = input
    let other = input
    visit { [copy = other] in copy + value }
    let next = value + 1
    sink(next)
  }
}
