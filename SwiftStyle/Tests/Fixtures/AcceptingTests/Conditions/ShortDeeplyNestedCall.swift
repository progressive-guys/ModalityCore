enum Examples {

  static func deepShortCall(_ value: Int) -> Bool {
    if abs(abs(abs(value))) > 0 { return true }
    return false
  }
}
