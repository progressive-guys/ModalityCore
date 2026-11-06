enum Examples {

  static func labeledCondition(_ value: Int) -> Bool {
    check: if value + 1 + 2 > 0 { break check }
    return false
  }
}
