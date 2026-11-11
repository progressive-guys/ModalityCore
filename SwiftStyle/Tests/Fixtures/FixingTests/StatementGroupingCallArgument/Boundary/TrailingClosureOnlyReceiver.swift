// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = [input]
    value.forEach { sink($0) }

    let next = value.count
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = [input]
    value.forEach { sink($0) }
    let next = value.count
    sink(next)
  }
}
