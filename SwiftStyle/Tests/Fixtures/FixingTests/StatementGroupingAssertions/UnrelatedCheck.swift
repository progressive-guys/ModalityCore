// MARK: - Input
import XCTest

enum Example {

  static func run(input: Int) {
    var result = input
    let original = input
    result = input + 1
    XCTAssertEqual(original, input)
  }
}

// MARK: - Output
import XCTest

enum Example {

  static func run(input: Int) {
    var result = input
    let original = input
    result = input + 1

    XCTAssertEqual(original, input)
  }
}
