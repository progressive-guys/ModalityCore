// MARK: - Input

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let value = max(
      input,
      other
    )


    sink(value)
  }
}

// MARK: - Output

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let value = max(
      input,
      other
    )

    sink(value)
  }
}
