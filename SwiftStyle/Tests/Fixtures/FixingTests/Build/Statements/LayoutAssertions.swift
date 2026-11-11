// MARK: - Input
import XCTest

enum LayoutTest {

  static func verify(_ pages: [[Int]]) {
    let layout = pages
      .flatMap { $0 }
      .prefix(
        2
      )


    XCTAssertEqual(layout.count, 2)
    XCTAssertEqual(layout.first, 1)
    XCTAssertEqual(layout.last, 2)
  }
}

// MARK: - Output
import XCTest

enum LayoutTest {

  static func verify(_ pages: [[Int]]) {
    let layout = pages
      .flatMap { $0 }
      .prefix(
        2
      )

    XCTAssertEqual(layout.count, 2)
    XCTAssertEqual(layout.first, 1)
    XCTAssertEqual(layout.last, 2)
  }
}
