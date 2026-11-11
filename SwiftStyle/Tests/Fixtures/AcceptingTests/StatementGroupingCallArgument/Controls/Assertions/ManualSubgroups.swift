import XCTest

enum Example {

  static func run(input: Int, other: Int, sink: (Int) -> Void) {
    let first = input
    let second = other

    XCTAssertGreaterThan(first, 0)

    XCTAssertGreaterThan(second, 0)
  }
}
