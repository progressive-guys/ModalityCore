enum Examples {

  static func guardNestedCall(_ value: Int) -> Bool {
    guard abs(abs(value)) > 0 else { return false }
    return true
  }
}
