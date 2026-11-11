// MARK: - Input

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let callback: () -> Void = {
      sink(input)
    }
    callback()
  }
}

// MARK: - Output

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let callback: () -> Void = {
      sink(input)
    }

    callback()
  }
}
