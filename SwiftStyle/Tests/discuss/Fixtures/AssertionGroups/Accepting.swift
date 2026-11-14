// MARK: - Case ManualAssertionSubgroups
import XCTest

func run(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input
  let second = other

  XCTAssertGreaterThan(first, 0)

  XCTAssertGreaterThan(second, 0)
}

// MARK: - Case MultilineLayoutZeroGap
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
