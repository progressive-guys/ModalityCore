enum Examples {

  static func nestedComment(_ value: Int) -> Bool {
    if abs(/* input */ abs(value)) > 0 { return true }
    return false
  }
}
