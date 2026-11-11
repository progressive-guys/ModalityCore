// MARK: - Input

enum Example {

  static func advance(_ value: inout Int) -> Int { value += 1; return value }

  static func run(input: Int, sink: (Int) -> Void) {
    var value = input
    sink(advance(&value))

    let next = value + 1
    sink(next)
  }
}

// MARK: - Output

enum Example {

  static func advance(_ value: inout Int) -> Int { value += 1; return value }

  static func run(input: Int, sink: (Int) -> Void) {
    var value = input
    sink(advance(&value))
    let next = value + 1
    sink(next)
  }
}
