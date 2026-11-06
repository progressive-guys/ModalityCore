enum Examples {

  struct Item {
    let value: Int
  }

  struct Input {
    let item: Item
  }

  static func conversion(_ input: Input, _ second: Input, _ divisor: Int) -> Double {
    let result = Double(abs(input.item.value) - abs(second.item.value))
      / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }
}
