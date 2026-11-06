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
  static func expandedConversion(_ input: Operands.Input, _ second: Operands.Input, _ divisor: Int) -> Double {
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

  static func expandedConversion(_ input: Operands.Input, _ second: Operands.Input, _ divisor: Int) -> Double {
    let result = Double(abs(input.item.value) - abs(second.item.value)) / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }

  static func splitConversion(_ first: Int, _ second: Int) -> Double {
    Double(first - second) / 12
  }
}
