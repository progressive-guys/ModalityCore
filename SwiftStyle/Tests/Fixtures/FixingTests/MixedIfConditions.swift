// MARK: - Input
enum Examples {
  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    if first, second,
      third { return true }
    return false
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    if first,
      second,
      third
    { return true }

    return false
  }
}
