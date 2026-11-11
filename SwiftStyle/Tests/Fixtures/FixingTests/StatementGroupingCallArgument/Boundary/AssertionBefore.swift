// MARK: - Input
import XCTest

enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input

    XCTAssertEqual(value, input)
    let next = abs(value)
    sink(next)
  }
}

// MARK: - Output
import XCTest

enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    XCTAssertEqual(value, input)

    let next = abs(value)
    sink(next)
  }
}
