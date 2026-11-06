enum Examples {

  static func whereCondition(_ values: [Int]) -> Bool {
    for value in values where value + 1 + 2 > 0 { return true }
    return false
  }
}
