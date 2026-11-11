// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    var value: [Int] = []
    value.append(input)

    let next = value.count
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    var value: [Int] = []
    value.append(input)
    let next = value.count
    sink(next)
  }
}
