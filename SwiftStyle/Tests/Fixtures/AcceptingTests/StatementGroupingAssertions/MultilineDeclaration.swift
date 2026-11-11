import XCTest

enum Example {

  static func run(input: Int) {
    let result = abs(
      input
    )

    XCTAssertEqual(result, abs(input))
  }
}
