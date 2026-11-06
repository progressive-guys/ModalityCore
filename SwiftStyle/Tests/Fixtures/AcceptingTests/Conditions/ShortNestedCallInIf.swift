enum Examples {

  static func nestedCall(_ value: Int) -> Bool {
    if abs(abs(value)) > 0 { return true }
    return false
  }
}
