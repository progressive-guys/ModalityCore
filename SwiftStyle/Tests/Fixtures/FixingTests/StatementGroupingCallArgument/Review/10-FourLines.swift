// MARK: - Input

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let value = input

    let next = other
    let sum = value + next
    sink(sum)
  }
}

// MARK: - Output

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let value = input
    let next = other
    let sum = value + next
    sink(sum)
  }
}
