struct Logger {
  func write(_ number: Int) {} }

enum Example {

  static func makeLogger() -> Logger { Logger() }

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    makeLogger().write(value)

    let next = value + 1
    sink(next)
  }
}
