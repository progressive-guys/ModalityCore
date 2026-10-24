// MARK: - Accepted

enum Accepted {
  static func inline(_ first: Int, _ second: Int) -> Double {
    Double(first - second) / 12
  }

  static func rightConversion(_ first: Int, _ second: Int) -> Double {
    12 / Double(
      first - second
    )
  }

  static func longFirstLine(_ first: Double, _ second: Double) -> Double {
    let result = Double(first
      - second
      + first
    ) / 12
    return result
  }

  static func tuple(_ first: Int, _ second: Int) -> (Int, Int) {
    (
      first,
      second
    )
  }

  static func collection(_ first: Int, _ second: Int) -> [Int] {
    [
      first,
      second
    ]
  }

  static func nestedClosingDelimiters(_ first: Int, _ second: Int) -> Double {
    Double(max(
      first,
      second
    ))
  }

  static func closure(_ values: [Int]) -> [Int] {
    values.map({ value in
      value + 1
    })
  }

  static func remainingArgument(_ first: Int, _ second: Int) -> [[Int]] {
    Array(repeating: [
      first,
      second
    ], count: 2)
  }

  static func nestedMember(_ values: [Int]) -> Bool {
    Bool(Array(
      values
    ).isEmpty)
  }

  static func castCollection(_ first: Int) -> [Int] {
    ([
      first
    ] as [Int]).map { $0 }
  }

  static func multilineString() -> [UInt8] {
    Array("""
    first
    second
    """.utf8)
  }

  static func rawMultilineString() -> [UInt8] {
    Array(#"""
    first
    second
    """#.utf8)
  }

  static func invokedClosure(_ first: Int) -> Int {
    Int({
      first
    }())
  }

}

// MARK: - Rejected

enum Rejected {
  static func call(_ first: Int, _ second: Int) -> Double {
    Double(first
      - second) / 12
  }

  static func arguments(_ first: Int, _ second: Int) -> Int {
    max(first,
      second)
  }

  static func tuple(_ first: Int, _ second: Int) -> (Int, Int) {
    (
      first,
      second)
  }

  static func array(_ first: Int, _ second: Int) -> [Int] {
    [
      first,
      second]
  }

  static func dictionary(_ first: Int, _ second: Int) -> [String: Int] {
    ["first": first,
      "second": second]
  }

  static func subscriptCall(_ first: Int, _ second: Int) -> Int {
    [first, second][
      0]
  }

  static func longFirstLine(_ first: Double, _ second: Double) -> Double {
    let result = Double(first -
      second +
      first) / 12
    return result
  }

  static func arithmeticAfterCollection(_ first: Int) -> Int {
    ([
      first
    ].count + 1)
  }

  static func ternaryAfterCollection(_ first: Int) -> Int {
    ([
      first
    ].isEmpty ? 0 : first)
  }

  static func sameLineClosureBody(_ first: Int) -> Int {
    Int({
      first + 1 }())
  }

  static func singleLineString() -> Int? {
    Int(
      "1")
  }

}
