enum Examples {

  static func multilineNestedCall(_ value: Int) -> Bool {
    if abs(abs(
      value
    )) > 0 { return true }

    return false
  }
}
