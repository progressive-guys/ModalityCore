enum Examples {

  static func nestedAtLimit(_ text: String) -> Bool {
    if text.hasPrefix("012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234".lowercased()) { return true }
    return false
  }
}
