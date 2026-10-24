// MARK: - Accepted

enum Accepted {
  struct Item {
    let numericValueStorage: Int
  }

  struct Input {
    let item: Item
  }

  static func value(_ first: Int, _ second: Int) -> Int {
    first + abs(second)
  }

  static func conversion(_ input: Input, _ secondaryData: Input, _ normalizationValue: Int) -> Double {
    let computedValue = Double(input.item.numericValueStorage - secondaryData.item.numericValueStorage)
      / Double(normalizationValue)
    return computedValue
  }

  static func longFirstLine(_ firstNumericInputParameter: Double, _ secondNumericInputParameter: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedValue = Double(firstNumericInputParameter
      - secondNumericInputParameter
      + firstNumericInputParameter
    ) / 12
    return resultWithAnExplicitNameForTheComputedValue
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
  static func expandedConversion(_ input: Accepted.Input, _ secondaryData: Accepted.Input, _ normalizationValue: Int) -> Double {
    let computedValue = Double(
      input.item.numericValueStorage - secondaryData.item.numericValueStorage
    ) / Double(normalizationValue)
    return computedValue
  }

  static func splitConversion(_ first: Int, _ second: Int) -> Double {
    Double(first -
      second) / 12
  }
}
