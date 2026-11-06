enum Examples {

  static func closurePredicate(_ values: [Any]) -> Bool {
    if values.contains(where: { $0 is Int }) { return true }
    return false
  }
}
