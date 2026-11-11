// MARK: - Input
import XCTest

enum Example {

  static func run(input: Int) {
    var result = input

    XCTAssertEqual(result, input)
    result = input + 1

    XCTAssertEqual(result, input + 1)
    result = input + 2

    XCTAssertEqual(result, input + 2)
  }
}

// MARK: - Output
import XCTest

enum Example {

  static func run(input: Int) {
    var result = input
    XCTAssertEqual(result, input)

    result = input + 1
    XCTAssertEqual(result, input + 1)

    result = input + 2
    XCTAssertEqual(result, input + 2)
  }
}
