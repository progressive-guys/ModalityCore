enum Examples {

  static func shortPredicate(_ values: [Int]) -> Bool {
    if values.contains(where: { $0 > 0 }) { return true }
    return false
  }
}
