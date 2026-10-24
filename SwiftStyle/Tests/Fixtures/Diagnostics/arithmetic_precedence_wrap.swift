// MARK: - Accepted

enum Accepted {
  struct Item {
    let numericValueStorage: Int
  }

  struct Input {
    let item: Item
  }

  static func computedValue(_ input: Input, _ secondaryData: Input, _ normalizationValue: Int) -> Double {
    let computedValue = Double(input.item.numericValueStorage - secondaryData.item.numericValueStorage)
      / Double(normalizationValue)
    return computedValue
  }

  static func product(_ firstInputParameter: Double, _ secondNumericArgument: Double, _ thirdInputValue: Double, _ fourthInputParameter: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedValue = firstInputParameter
      + secondNumericArgument * thirdInputValue
      - fourthInputParameter
    return resultWithAnExplicitNameForTheComputedValue
  }

  static func longProduct(_ first: Double, _ second: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedValue = max(abs(first), abs(second))
      * min(abs(first), abs(second))
      / max(abs(first), abs(second))
    return resultWithAnExplicitNameForTheComputedValue
  }

  static func grouped(_ first: Double, _ second: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedValue = (max(abs(first), abs(second)) - min(abs(first), abs(second)))
      / max(abs(first), abs(second))
    return resultWithAnExplicitNameForTheComputedValue
  }

  static func longAdditiveSegment(_ first: Double, _ second: Double) -> Double {
    let combinedValue = max(abs(first), abs(second))
      + abs(max(abs(first), abs(second)))
      * abs(min(abs(first), abs(second)))
      * abs(max(abs(first), abs(second)))
      * abs(min(abs(first), abs(second)))
    return combinedValue
  }

  static func longCall(_ first: Double, _ second: Double) -> Double {
    let combinedValue = Double(abs(max(abs(first), abs(second)))
      + abs(min(abs(first), abs(second)))
      + abs(max(abs(first), abs(second)))
      + abs(min(abs(first), abs(second)))
    ) / max(abs(first), abs(second))
    return combinedValue
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
    let resultWithAnExplicitNameForTheComputedValue = -(max(abs(first), abs(second)) - min(abs(first), abs(second)))
      / max(abs(first), abs(second))
    return resultWithAnExplicitNameForTheComputedValue
  }

  static func shortConversion(_ first: Int, _ second: Int) -> Double {
    Double(first - second) / 12
  }
}

// MARK: - Rejected

enum Rejected {
  static func computedValue(_ input: Accepted.Input, _ secondaryData: Accepted.Input, _ normalizationValue: Int) -> Double {
    let computedValue = Double(input.item.numericValueStorage -
      secondaryData.item.numericValueStorage) / Double(normalizationValue)
    return computedValue
  }

  static func shortExpression(_ first: Double, _ second: Double) -> Double {
    first
      + second
  }

  static func splitProduct(_ firstInputParameter: Double, _ secondNumericArgument: Double, _ thirdInputValue: Double, _ fourthInputParameter: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedValue = firstInputParameter + secondNumericArgument
      * thirdInputValue - fourthInputParameter
    return resultWithAnExplicitNameForTheComputedValue
  }

  static func wrongIndent(_ first: Double, _ second: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedValue = (max(abs(first), abs(second)) -
        min(abs(first), abs(second))) / max(abs(first), abs(second))
    return resultWithAnExplicitNameForTheComputedValue
  }

  static func laterAdditiveTerm(_ first: Double, _ second: Double) -> Double {
    let resultWithAnExplicitNameForTheComputedValue = max(abs(first), abs(second))
      / min(abs(first), abs(second)) + max(abs(first), abs(second))
    return resultWithAnExplicitNameForTheComputedValue
  }

  static func splitRemainder(_ first: Int, _ second: Int) -> Int {
    let resultWithAnExplicitNameForTheComputedValue = max(abs(first), abs(second))
      % min(abs(first), abs(second)) + max(abs(first), abs(second))
    return resultWithAnExplicitNameForTheComputedValue
  }

  static func shortConversion(_ first: Int, _ second: Int) -> Double {
    Double(first -
      second) / 12
  }
}
