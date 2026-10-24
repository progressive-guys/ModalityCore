// MARK: - Accepted

enum Accepted {
  struct Item {
    let value: Int
  }

  struct Input {
    let item: Item
  }

  static func computedValue(_ input: Input, _ second: Input, _ divisor: Int) -> Double {
    let result = Double(input.item.value - second.item.value)
      / Double(divisor)
    return result
  }

  static func product(_ first: Double, _ second: Double, _ third: Double, _ fourth: Double) -> Double {
    let result = first
      + second * third
      - fourth
    return result
  }

  static func longProduct(_ first: Double, _ second: Double) -> Double {
    let result = first
      * second
      / first
    return result
  }

  static func grouped(_ first: Double, _ second: Double) -> Double {
    let result = (first - second)
      / first
    return result
  }

  static func longAdditiveSegment(_ first: Double, _ second: Double) -> Double {
    let result = first
      + abs(first)
      * abs(second)
      * abs(first)
      * abs(second)
    return result
  }

  static func longCall(_ first: Double, _ second: Double) -> Double {
    let result = Double(abs(first)
      + abs(second)
      + abs(first)
      + abs(second)
    ) / first
    return result
  }

  static func short(_ first: Double, _ second: Double) -> Double {
    first + second * 2
  }

  static func commented(_ first: Double, _ second: Double) -> Double {
    first
      // Keep the documented boundary.
      * second
  }

  static func multipleArguments(_ first: Double, _ second: Double) -> Double {
    max(
      first,
      second
    ) / 2
  }

  static func unary(_ first: Double, _ second: Double) -> Double {
    let result = -(first - second)
      / first
    return result
  }

  static func shortConversion(_ first: Int, _ second: Int) -> Double {
    Double(first - second) / 12
  }
}

// MARK: - Rejected

enum Rejected {
  static func computedValue(_ input: Accepted.Input, _ second: Accepted.Input, _ divisor: Int) -> Double {
    let result = Double(input.item.value -
      second.item.value) / Double(divisor)
    return result
  }

  static func shortExpression(_ first: Double, _ second: Double) -> Double {
    first
      + second
  }

  static func splitProduct(_ first: Double, _ second: Double, _ third: Double, _ fourth: Double) -> Double {
    let result = first + second
      * third - fourth
    return result
  }

  static func wrongIndent(_ first: Double, _ second: Double) -> Double {
    let result = (first -
        second) / first
    return result
  }

  static func laterAdditiveTerm(_ first: Double, _ second: Double) -> Double {
    let result = first
      / second + first
    return result
  }

  static func splitRemainder(_ first: Int, _ second: Int) -> Int {
    let result = first
      % second + first
    return result
  }

  static func shortConversion(_ first: Int, _ second: Int) -> Double {
    Double(first -
      second) / 12
  }
}
