// MARK: - Input

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let base = input
    let count = other
    let scaled = base * 2

    let width = other + 1
    sink(scaled + count + width)
  }
}

// MARK: - Output

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let base = input
    let count = other
    let scaled = base * 2

    let width = other + 1

    sink(scaled + count + width)
  }
}
