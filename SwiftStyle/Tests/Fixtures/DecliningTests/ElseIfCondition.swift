enum Examples {

  static func elseIfCondition(_ enabled: Bool, _ value: Int) -> Bool {
    if enabled { return true } else if value + 1 + 2 > 0 { return true }
    return false
  }
}
