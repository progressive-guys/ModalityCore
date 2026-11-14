// MARK: - Case ArithmeticAfterCollection
// MARK: Input
func arithmeticAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].count + 1)
}

// MARK: Output
func arithmeticAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].count + 1
  )
}

// MARK: - Case ArrayClosingDelimiter
// MARK: Input
func array(_ first: Int, _ second: Int) -> [Int] {
  [
    first,
    second]
}

// MARK: Output
func array(_ first: Int, _ second: Int) -> [Int] {
  [
    first,
    second
  ]
}

// MARK: - Case CallClosingDelimiter
// MARK: Input
func arguments(_ first: Int, _ second: Int) -> Int {
  max(first,
    second)
}

// MARK: Output
func arguments(_ first: Int, _ second: Int) -> Int {
  max(first,
    second
  )
}

// MARK: - Case DictionaryClosingDelimiter
// MARK: Input
func dictionary(_ first: Int, _ second: Int) -> [String: Int] {
  ["first": first,
    "second": second]
}

// MARK: Output
func dictionary(_ first: Int, _ second: Int) -> [String: Int] {
  ["first": first,
    "second": second
  ]
}

// MARK: - Case InvokedClosureClosingDelimiter
// MARK: Input
func sameLineClosureBody(_ first: Int) -> Int {
  Int({
    first + 1 }())
}

// MARK: Output
func sameLineClosureBody(_ first: Int) -> Int {
  Int({
    first + 1 }()
  )
}

// MARK: - Case PartlyMultilineGetterBody
// MARK: Input
enum Examples {
  static var value: Int { 1
  }
}

// MARK: Output
enum Examples {

  static var value: Int {
    1
  }
}

// MARK: - Case StringArgumentClosingDelimiter
// MARK: Input
func singleLineString() -> Int? {
  Int(
    "1")
}

// MARK: Output
func singleLineString() -> Int? {
  Int(
    "1"
  )
}

// MARK: - Case SubscriptClosingDelimiter
// MARK: Input
func subscriptCall(_ first: Int, _ second: Int) -> Int {
  [first, second][
    0]
}

// MARK: Output
func subscriptCall(_ first: Int, _ second: Int) -> Int {
  [first, second][
    0
  ]
}

// MARK: - Case TernaryAfterCollection
// MARK: Input
func ternaryAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].isEmpty ? 0 : first)
}

// MARK: Output
func ternaryAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].isEmpty ? 0 : first
  )
}

// MARK: - Case TupleClosingDelimiter
// MARK: Input
func tuple(_ first: Int, _ second: Int) -> (Int, Int) {
  (
    first,
    second)
}

// MARK: Output
func tuple(_ first: Int, _ second: Int) -> (Int, Int) {
  (
    first,
    second
  )
}
