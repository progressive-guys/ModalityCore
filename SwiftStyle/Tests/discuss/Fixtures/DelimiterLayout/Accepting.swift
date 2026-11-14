// MARK: - Case AdjacentClosingParentheses
enum Examples {

  static func nestedClosingDelimiters(_ first: Int, _ second: Int) -> Double {
    Double(max(
      first,
      second
    ))
  }
}

// MARK: - Case CastAfterMultilineArray
enum Examples {

  static func castCollection(_ first: Int) -> [Int] {
    ([
      first
    ] as [Int]).map { $0 }
  }
}

// MARK: - Case ClosureArgument
enum Examples {

  static func closure(_ values: [Int]) -> [Int] {
    values.map({ value in
      value + 1
    })
  }
}

// MARK: - Case ImmediatelyCalledClosure
enum Examples {

  static func invokedClosure(_ first: Int) -> Int {
    Int({
      first
    }())
  }
}

// MARK: - Case MemberAfterMultilineCall
enum Examples {

  static func nestedMember(_ values: [Int]) -> Bool {
    Bool(Array(
      values
    ).isEmpty)
  }
}

// MARK: - Case MemberAfterMultilineString
enum Examples {

  static func multilineString() -> [UInt8] {
    Array("""
      first
      second
      """.utf8)
  }
}

// MARK: - Case MemberAfterRawMultilineString
enum Examples {

  static func rawMultilineString() -> [UInt8] {
    Array(#"""
      first
      second
      """#.utf8)
  }
}

// MARK: - Case RemainingArgumentAfterArray
enum Examples {

  static func remainingArgument(_ first: Int, _ second: Int) -> [[Int]] {
    Array(repeating: [
      first,
      second
    ], count: 2)
  }
}
