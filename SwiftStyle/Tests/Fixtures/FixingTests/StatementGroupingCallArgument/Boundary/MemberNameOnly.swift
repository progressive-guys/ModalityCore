// MARK: - Input
struct Box {
  let value: Int }

enum Example {

  static func pair(_ a: Int, _ b: Int) {}

  static func run(input: Int, box: Box, sink: (Int) -> Void) {
    let value = input
    let other = input
    pair(box.value, other)

    let next = value + 1
    sink(next)
  }
}

// MARK: - Output
struct Box {
  let value: Int }

enum Example {

  static func pair(_ a: Int, _ b: Int) {}

  static func run(input: Int, box: Box, sink: (Int) -> Void) {
    let value = input
    let other = input
    pair(box.value, other)
    let next = value + 1
    sink(next)
  }
}
