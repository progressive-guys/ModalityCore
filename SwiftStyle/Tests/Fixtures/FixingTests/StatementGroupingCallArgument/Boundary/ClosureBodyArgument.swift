// MARK: - Input
enum Example {

  static func run(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
    let value = input
    visit { value }

    let next = value + 1
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
    let value = input
    visit { value }
    let next = value + 1
    sink(next)
  }
}
