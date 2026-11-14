// MARK: - Case BindingJoinsIfExpression
// MARK: Input
enum Examples {
  static func value(_ first: Bool) -> Int {
    let
      result = if first { 1 } else { 0 }
    return result
  }
}

// MARK: Output
enum Examples {

  static func value(_ first: Bool) -> Int {
    let result = if first {
        1
      } else {
        0
      }
    return result
  }
}

// MARK: - Case BraceBeforeInlineReturnBody
// MARK: Input
enum Examples {
  static func value(_ first: Bool, _ second: Bool) -> Bool {
    if first,
      second { return true }
    return false
  }
}

// MARK: Output
enum Examples {

  static func value(_ first: Bool, _ second: Bool) -> Bool {
    if first,
      second
    { return true }

    return false
  }
}

// MARK: - Case CallConditionSharesClosingLineWithBrace
// MARK: Input
enum Examples {
  static func value(_ values: [Int], _ value: Int) -> Bool {
    if values.contains(
      value
    )
    { return true }
    return false
  }
}

// MARK: Output
enum Examples {

  static func value(_ values: [Int], _ value: Int) -> Bool {
    if values.contains(
      value
    ) { return true }

    return false
  }
}

// MARK: - Case CasePatternIndentAndFollowingGap
// MARK: Input
func select(_ value: Int) -> Int {
  switch value {
  case 1,
       2: 1
  default: 0
  }
}

// MARK: Output
func select(_ value: Int) -> Int {
  switch value {
  case 1,
    2: 1

  default: 0
  }
}

// MARK: - Case CompactGuardRemovesFollowingGap
// MARK: Input
func value(_ first: Bool) -> Int {
  guard first else {
    return 0
  }

  return 1
}

// MARK: Output
func value(_ first: Bool) -> Int {
  guard first else { return 0 }
  return 1
}

// MARK: - Case ContinuedIfExpressionCondition
// MARK: Input
enum Examples {
  static func value(_ first: Bool, _ second: Bool) -> Int {
    let result = if first,
                    second
    { 1 } else { 0 }
    return result
  }
}

// MARK: Output
enum Examples {

  static func value(_ first: Bool, _ second: Bool) -> Int {
    let result = if first,
      second
    {
      1
    } else {
      0
    }
    return result
  }
}

// MARK: - Case InlineReturnWithExpandedElseAction
// MARK: Input
func value(_ first: Bool) -> Void {
  if first { return } else { print("value") }
}

// MARK: Output
func value(_ first: Bool) -> Void {
  if first { return } else {
    print("value")
  }
}
