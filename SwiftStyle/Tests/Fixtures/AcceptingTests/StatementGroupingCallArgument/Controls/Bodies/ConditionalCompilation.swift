
enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let value = input

    #if os(macOS)
    let next = value + 1
    #else
    let next = value + 2
    #endif

    sink(next)
  }
}
