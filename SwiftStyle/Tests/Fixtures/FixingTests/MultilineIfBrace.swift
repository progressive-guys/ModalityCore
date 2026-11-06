// MARK: - Input
enum Examples {
  static func value(_ first: Bool, _ second: Bool) -> Bool {
    if first,
      second { return true }
    return false
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Bool, _ second: Bool) -> Bool {
    if first,
      second
    { return true }

    return false
  }
}
