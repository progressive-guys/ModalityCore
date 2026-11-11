// MARK: - Input

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let base = input
    let scaled = base * 2

    let count = other
    let spacing = scaled / max(count, 1)
    sink(spacing)
  }
}

// MARK: - Output

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let base = input
    let scaled = base * 2

    let count = other

    let spacing = scaled / max(count, 1)
    sink(spacing)
  }
}
