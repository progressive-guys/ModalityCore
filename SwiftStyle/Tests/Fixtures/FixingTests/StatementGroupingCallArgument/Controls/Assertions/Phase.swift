// MARK: - Input
import XCTest

enum Example {

  static func run(input: Int) {
    var value = input
    value += 1

    XCTAssertGreaterThan(value, input)
    XCTAssertEqual(value, input + 1)
  }
}

// MARK: - Output
import XCTest

enum Example {

  static func run(input: Int) {
    var value = input
    value += 1
    XCTAssertGreaterThan(value, input)
    XCTAssertEqual(value, input + 1)
  }
}
