// MARK: - Input

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let value = input
    let callback = { sink(value) }
    let next = other
    callback()
    sink(next)
  }
}

// MARK: - Output

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let value = input
    let callback = { sink(value) }

    let next = other

    callback()
    sink(next)
  }
}
