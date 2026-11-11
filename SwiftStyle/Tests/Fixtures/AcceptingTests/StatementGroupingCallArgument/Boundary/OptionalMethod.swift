struct Logger {
  func write(_ number: Int) {} }

enum Example {

  static func run(input: Int, log: Logger?, sink: (Int) -> Void) {
    let value = input
    log?.write(value)

    let next = value + 1
    sink(next)
  }
}
