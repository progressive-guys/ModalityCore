// MARK: - Case AssertionReadsOtherBinding
// MARK: Input
func run(input: Int) {
  var result = input
  let original = input
  result = input + 1
  XCTAssertEqual(original, input)
}

// MARK: Output
func run(input: Int) {
  var result = input
  let original = input
  result = input + 1

  XCTAssertEqual(original, input)
}

// MARK: - Case AssertionThenDerivedDeclaration
// MARK: Input
func run(input: Int, sink: (Int) -> Void) {
  let value = input

  XCTAssertEqual(value, input)
  let next = abs(value)
  sink(next)
}

// MARK: Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  XCTAssertEqual(value, input)

  let next = abs(value)
  sink(next)
}

// MARK: - Case AssignmentAssertionPairs
// MARK: Input
func run(input: Int) {
  var result = input

  XCTAssertEqual(result, input)
  result = input + 1

  XCTAssertEqual(result, input + 1)
}

// MARK: Output
func run(input: Int) {
  var result = input
  XCTAssertEqual(result, input)

  result = input + 1
  XCTAssertEqual(result, input + 1)
}

// MARK: - Case CompoundMutationAssertions
// MARK: Input

func run(input: Int) {
  var result = input
  result += 1

  XCTAssertGreaterThan(result, input)
  XCTAssertEqual(result, input + 1)
}

// MARK: Output

func run(input: Int) {
  var result = input
  result += 1
  XCTAssertGreaterThan(result, input)
  XCTAssertEqual(result, input + 1)
}

// MARK: - Case ExpectMacroPairs
// MARK: Input
func run(input: Int) {
  let first = input + 1

  #expect(first > input)
  let second = input + 2

  #expect(second > input)
}

// MARK: Output
func run(input: Int) {
  let first = input + 1
  #expect(first > input)

  let second = input + 2
  #expect(second > input)
}

// MARK: - Case ImmediatelyInvokedClosureArgument
// MARK: Input
func run(input: Int) {
  let result = input
  XCTAssertTrue({ result == input }())
  XCTAssertEqual(result, input)
  XCTAssertGreaterThanOrEqual(result, Int.min)
}

// MARK: Output
func run(input: Int) {
  let result = input

  XCTAssertTrue({ result == input }())
  XCTAssertEqual(result, input)
  XCTAssertGreaterThanOrEqual(result, Int.min)
}

// MARK: - Case MultilineLayoutExcessGap
// MARK: Input
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

// MARK: Output
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

// MARK: - Case PreparationThenExpectPhase
// MARK: Input
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input
  let second = other
  #expect(first > 0)
  #expect(second > 0)
}

// MARK: Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input
  let second = other

  #expect(first > 0)
  #expect(second > 0)
}
