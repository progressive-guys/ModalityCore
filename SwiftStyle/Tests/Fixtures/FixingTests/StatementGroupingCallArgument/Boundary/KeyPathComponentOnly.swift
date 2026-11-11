// MARK: - Input
struct Box {
  let value: Int }

enum Example {

  static func log(_ path: KeyPath<Box, Int>, _ value: Int) {}

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    let other = input
    log(\Box.value, other)

    let next = value + 1
    sink(next)
  }
}

// MARK: - Output
struct Box {
  let value: Int }

enum Example {

  static func log(_ path: KeyPath<Box, Int>, _ value: Int) {}

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    let other = input
    log(\Box.value, other)
    let next = value + 1
    sink(next)
  }
}
