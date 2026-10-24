// MARK: - Accepted

enum Accepted {
  static func value(_ firstConditionWithLongName: Int, _ expectedValueWithLongName: Int,
    _ secondConditionWithLongName: Int, _ anotherExpectedValueWithLongName: Int) -> Bool {
    guard
      firstConditionWithLongName == expectedValueWithLongName,
      secondConditionWithLongName == anotherExpectedValueWithLongName
    else { return false }

    return true
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ firstConditionWithLongName: Int, _ expectedValueWithLongName: Int,
    _ secondConditionWithLongName: Int, _ anotherExpectedValueWithLongName: Int) -> Bool {
    guard firstConditionWithLongName == expectedValueWithLongName,
      secondConditionWithLongName == anotherExpectedValueWithLongName
    else { return false }

    return true
  }
}
