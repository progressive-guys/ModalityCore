// MARK: - Input

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let base = input
    let scaled = base * 2


    let count = other


    let sum = scaled + count
    sink(sum)
  }
}

// MARK: - Output

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let base = input
    let scaled = base * 2

    let count = other

    let sum = scaled + count
    sink(sum)
  }
}
