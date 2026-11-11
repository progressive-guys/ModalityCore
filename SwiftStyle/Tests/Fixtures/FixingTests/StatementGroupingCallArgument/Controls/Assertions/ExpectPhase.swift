// MARK: - Input
import Testing

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let first = input
    let second = other
    #expect(first > 0)
    #expect(second > 0)
  }
}

// MARK: - Output
import Testing

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let first = input
    let second = other

    #expect(first > 0)
    #expect(second > 0)
  }
}
