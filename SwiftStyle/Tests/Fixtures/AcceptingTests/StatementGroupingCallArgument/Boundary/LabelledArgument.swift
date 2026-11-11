
enum Example {

  static func log(message: Int) {}

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    log(message: value)

    let next = value + 1
    sink(next)
  }
}
