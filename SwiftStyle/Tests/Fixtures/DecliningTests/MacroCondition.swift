enum Examples {

  static func macroCondition() -> Bool {
    if #line + 1 + 2 > 0 { return true }
    return false
  }
}
