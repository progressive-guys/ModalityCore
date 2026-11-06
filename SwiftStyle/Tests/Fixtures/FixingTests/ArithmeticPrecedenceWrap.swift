// MARK: - Input
enum Operands {
  struct Item {
    let value: Int
  }

  struct Input {
    let item: Item
  }
}


enum Examples {
  static func computedValue(_ input: Operands.Input, _ second: Operands.Input, _ divisor: Int) -> Double {
    let result = Double(abs(input.item.value) -
      abs(second.item.value)) / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }

  static func shortExpression(_ first: Double, _ second: Double) -> Double {
    first
      + second
  }

  static func splitProduct(_ first: Double, _ second: Double, _ third: Double, _ fourth: Double) -> Double {
    let result = max(abs(first), abs(second)) + min(abs(second), abs(third))
      * max(abs(third), abs(fourth)) - min(abs(first), abs(fourth))
    return result
  }

  static func wrongIndent(_ first: Double, _ second: Double) -> Double {
    let result = (max(first.magnitude, second.magnitude) -
        min(first.magnitude, second.magnitude)) / max(first.magnitude, second.magnitude)
    return result
  }

  static func laterAdditiveTerm(_ first: Double, _ second: Double) -> Double {
    let result = max(first.magnitude, second.magnitude)
      / min(first.magnitude, second.magnitude) + max(first.magnitude, second.magnitude)
    return result
  }

  static func splitRemainder(_ first: Int, _ second: Int) -> Int {
    let result = max(abs(first), abs(second), 1_000)
      % min(abs(first), abs(second), 1_000) + max(abs(first), abs(second), 1_000)
    return result
  }

  static func shortConversion(_ first: Int, _ second: Int) -> Double {
    Double(first -
      second) / 12
  }
}

// MARK: - Output
enum Operands {

  struct Item {
    let value: Int
  }

  struct Input {
    let item: Item
  }
}


enum Examples {

  static func computedValue(_ input: Operands.Input, _ second: Operands.Input, _ divisor: Int) -> Double {
    let result = Double(abs(input.item.value) - abs(second.item.value))
      / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }

  static func shortExpression(_ first: Double, _ second: Double) -> Double {
    first + second
  }

  static func splitProduct(_ first: Double, _ second: Double, _ third: Double, _ fourth: Double) -> Double {
    let result = max(abs(first), abs(second))
      + min(abs(second), abs(third)) * max(abs(third), abs(fourth))
      - min(abs(first), abs(fourth))
    return result
  }

  static func wrongIndent(_ first: Double, _ second: Double) -> Double {
    let result = (max(first.magnitude, second.magnitude) - min(first.magnitude, second.magnitude))
      / max(first.magnitude, second.magnitude)
    return result
  }

  static func laterAdditiveTerm(_ first: Double, _ second: Double) -> Double {
    let result = max(first.magnitude, second.magnitude) / min(first.magnitude, second.magnitude)
      + max(first.magnitude, second.magnitude)
    return result
  }

  static func splitRemainder(_ first: Int, _ second: Int) -> Int {
    let result = max(abs(first), abs(second), 1_000) % min(abs(first), abs(second), 1_000)
      + max(abs(first), abs(second), 1_000)
    return result
  }

  static func shortConversion(_ first: Int, _ second: Int) -> Double {
    Double(first - second) / 12
  }
}
