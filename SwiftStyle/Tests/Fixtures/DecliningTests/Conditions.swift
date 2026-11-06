enum Examples {

  static func conditionalTail(_ enabled: Bool, _ value: Int) -> Bool {
    if enabled, value + 1 + 2 > 0 { return true }
    return false
  }
}
