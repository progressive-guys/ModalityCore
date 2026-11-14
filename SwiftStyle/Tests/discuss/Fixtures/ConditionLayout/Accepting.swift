// MARK: - Case ArrayReceiverConditionKeepsSeparateBrace
enum Examples {

  static func arrayLiteral(_ value: String) -> Bool {
    if [
      "first", "second"
    ].contains(value)
    { return true }

    return false
  }
}

// MARK: - Case IfExpressionBodyAtBindingIndent
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

// MARK: - Case NestedCallInIfExpressionCondition
enum Examples {

  static func nestedArguments(_ argument: Int, _ first: Bool) -> Int {
    let result = if abs(
      abs(
        argument
      )
    ) > 0,
      first
    {
      1
    } else {
      0
    }
    return result
  }
}
