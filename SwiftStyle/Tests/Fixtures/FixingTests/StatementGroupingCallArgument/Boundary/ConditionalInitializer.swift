// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    let next = if input > 0 {
      value
    } else {
      0
    }
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    let next = if input > 0 {
      value
    } else {
      0
    }

    sink(next)
  }
}
