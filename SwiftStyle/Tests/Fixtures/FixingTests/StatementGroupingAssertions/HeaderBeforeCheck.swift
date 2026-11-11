// MARK: - Input
import XCTest

enum Example {

  static func run(input: Int) {
    let result = abs(input)
    // Verify the result.
    XCTAssertGreaterThanOrEqual(result, 0)
    XCTAssertEqual(result, abs(input))
  }
}

// MARK: - Output
import XCTest

enum Example {

  static func run(input: Int) {
    let result = abs(input)

    // Verify the result.
    XCTAssertGreaterThanOrEqual(result, 0)
    XCTAssertEqual(result, abs(input))
  }
}
