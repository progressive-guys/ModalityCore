// MARK: - Input

enum Example {

  static func touch(_ value: inout Int) { value += 1 }

  static func run(input: Int, sink: (Int) -> Void) {
    var value = input
    touch(&value)

    let next = value + 1
    sink(next)
  }
}

// MARK: - Output

enum Example {

  static func touch(_ value: inout Int) { value += 1 }

  static func run(input: Int, sink: (Int) -> Void) {
    var value = input
    touch(&value)
    let next = value + 1
    sink(next)
  }
}
