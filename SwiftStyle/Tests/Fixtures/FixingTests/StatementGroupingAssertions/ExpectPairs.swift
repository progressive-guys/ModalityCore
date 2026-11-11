// MARK: - Input
import Testing

enum Example {

  static func run(input: Int) {
    let first = input + 1

    #expect(first > input)
    let second = input + 2

    #expect(second > input)
  }
}

// MARK: - Output
import Testing

enum Example {

  static func run(input: Int) {
    let first = input + 1
    #expect(first > input)

    let second = input + 2
    #expect(second > input)
  }
}
