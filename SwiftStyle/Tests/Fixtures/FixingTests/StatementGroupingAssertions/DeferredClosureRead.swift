// MARK: - Input
import XCTest

enum Example {

  static func run(input: Int) {
    let result = input
    XCTAssertTrue({ result == input }())
    XCTAssertEqual(result, input)
    XCTAssertGreaterThanOrEqual(result, Int.min)
  }
}

// MARK: - Output
import XCTest

enum Example {

  static func run(input: Int) {
    let result = input

    XCTAssertTrue({ result == input }())
    XCTAssertEqual(result, input)
    XCTAssertGreaterThanOrEqual(result, Int.min)
  }
}
