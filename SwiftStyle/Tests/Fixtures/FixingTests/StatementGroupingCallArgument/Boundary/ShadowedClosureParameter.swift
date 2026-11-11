// MARK: - Input
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    let other = input
    sink([other].map { value in value }.count)

    let next = value + 1
    sink(next)
  }
}

// MARK: - Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    let other = input
    sink([other].map { value in value }.count)
    let next = value + 1
    sink(next)
  }
}
