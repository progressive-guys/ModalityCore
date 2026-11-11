// MARK: - Input
import XCTest

enum Example {

  static func run(input: Int) {
    var result = input
    result += 1

    XCTAssertGreaterThan(result, input)
    XCTAssertEqual(result, input + 1)
  }
}

// MARK: - Output
import XCTest

enum Example {

  static func run(input: Int) {
    var result = input
    result += 1
    XCTAssertGreaterThan(result, input)
    XCTAssertEqual(result, input + 1)
  }
}
