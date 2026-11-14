// MARK: - Case CommentBeforeOperator
enum Examples {

  static func commented(_ first: Double, _ second: Double) -> Double {
    first
      // Keep the documented boundary.
      * second
  }
}

// MARK: - Case CompoundAssignmentKeepsOperatorAfterTarget
enum Examples {

  static func value(_ input: Int) -> Int {
    var value = input
    value +=
      input
    return value
  }
}

// MARK: - Case CompoundAssignmentWithMultilineString
enum Examples {

  static func multilineStringAssignment() -> String {
    var value = ""
    value +=
      """
      first
      second
      """
    return value
  }
}

// MARK: - Case DivisionAfterLongArgumentExpression
enum Examples {

  static func longCall(_ first: Double, _ second: Double) -> Double {
    let result = Double(abs(max(abs(first), abs(second)))
      + abs(min(abs(first), abs(second)))
      + abs(max(abs(first), abs(second)))
      + abs(min(abs(first), abs(second)))
    ) / max(abs(first), abs(second))
    return result
  }
}

// MARK: - Case DivisionAfterMultilineCall
enum Examples {

  static func multipleArguments(_ first: Double, _ second: Double) -> Double {
    max(
      first,
      second
    ) / 2
  }
}

// MARK: - Case ExplicitGroupedOperand
enum Examples {
  static func grouped(_ first: Int, _ second: Int, _ third: Int) -> Int {
    (first + second) - third
  }
}

// MARK: - Case InlineComparisonStaysInline
enum Examples {
  static func value(_ first: Int, _ second: Int) -> Bool {
    first == second
  }
}

// MARK: - Case InlineRightConversion
enum Examples {
  static func rightConversion(_ first: Int, _ second: Int) -> Double {
    12 / Double(first - second)
  }
}

// MARK: - Case NegatedGroupBeforeDivision
enum Examples {

  static func unary(_ first: Double, _ second: Double) -> Double {
    let result = -(max(first.magnitude, second.magnitude) - min(first.magnitude, second.magnitude))
      / max(first.magnitude, second.magnitude)
    return result
  }
}

// MARK: - Case ShortMixedPrecedence
enum Examples {
  static func short(_ first: Double, _ second: Double) -> Double {
    first + second * 2
  }
}

// MARK: - Case WrappedMultiplicativeChain
enum Examples {

  static func longProduct(_ first: Double, _ second: Double) -> Double {
    let result = max(first.magnitude, second.magnitude)
      * min(first.magnitude, second.magnitude)
      / max(first.magnitude, second.magnitude)
    return result
  }
}

// MARK: - Case WrappedProductWithinSum
enum Examples {

  static func longAdditiveSegment(_ first: Double, _ second: Double) -> Double {
    let result = max(abs(first), abs(second))
      + abs(max(abs(first), abs(second)))
      * abs(min(abs(first), abs(second)))
      * abs(max(abs(first), abs(second)))
      * abs(min(abs(first), abs(second)))
    return result
  }
}
