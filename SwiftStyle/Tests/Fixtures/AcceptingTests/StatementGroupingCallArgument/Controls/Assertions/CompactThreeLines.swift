import XCTest

enum Example {

  static func run(input: Int) {
    let value = input
    XCTAssertGreaterThan(value, 0)
    XCTAssertEqual(value, input)
  }
}
