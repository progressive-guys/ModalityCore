// MARK: - Input
enum Examples {
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

// MARK: - Output
enum Examples {

  static func call(_ first: Int, _ second: Int) -> Double {
    Double(first - second) / 12
  }

  static func arguments(_ first: Int, _ second: Int) -> Int {
    max(first,
      second
    )
  }

  static func tuple(_ first: Int, _ second: Int) -> (Int, Int) {
    (
      first,
      second
    )
  }

  static func array(_ first: Int, _ second: Int) -> [Int] {
    [
      first,
      second
    ]
  }

  static func dictionary(_ first: Int, _ second: Int) -> [String: Int] {
    ["first": first,
      "second": second
    ]
  }

  static func subscriptCall(_ first: Int, _ second: Int) -> Int {
    [first, second][
      0
    ]
  }

  static func longFirstLine(_ first: Double, _ second: Double) -> Double {
    let result = Double(first - second + first) / 12
    return result
  }

  static func arithmeticAfterCollection(_ first: Int) -> Int {
    ([
      first
    ].count + 1
    )
  }

  static func ternaryAfterCollection(_ first: Int) -> Int {
    ([
      first
    ].isEmpty ? 0 : first
    )
  }

  static func sameLineClosureBody(_ first: Int) -> Int {
    Int({
      first + 1 }()
    )
  }

  static func singleLineString() -> Int? {
    Int(
      "1"
    )
  }

}
