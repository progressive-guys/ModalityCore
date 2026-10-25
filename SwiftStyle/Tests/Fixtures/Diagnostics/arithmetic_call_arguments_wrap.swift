// MARK: - Accepted

enum Accepted {
  struct Item {
    let value: Int
  }

  struct Input {
    let item: Item
  }

  static func value(_ first: Int, _ second: Int) -> Int {
    first + abs(second)
  }

  static func conversion(_ input: Input, _ second: Input, _ divisor: Int) -> Double {
    let result = Double(abs(input.item.value) - abs(second.item.value))
      / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }

  static func longFirstLine(_ first: Double, _ second: Double) -> Double {
    let result = Double(max(first.magnitude, second.magnitude)
      - min(first.magnitude, second.magnitude)
      + max(first.magnitude, second.magnitude)
    ) / 12
    return result
  }

  static func expandedRightValue(_ first: Int, _ second: Int) -> Int {
    first + abs(
      second
    )
  }

  static func rightConversion(_ first: Int, _ second: Int) -> Double {
    12 / Double(
      first - second
    )
  }
}

// MARK: - Rejected

enum Rejected {
  static func expandedConversion(_ input: Accepted.Input, _ second: Accepted.Input, _ divisor: Int) -> Double {
    let result = Double(
      abs(input.item.value) - abs(second.item.value)
    ) / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }

  static func splitConversion(_ first: Int, _ second: Int) -> Double {
    Double(first -
      second) / 12
  }
}
