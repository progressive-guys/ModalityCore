enum Examples {

  static func apiInsertedResult(_ values: inout Set<Int>, _ value: Int) -> Bool {
    if values.insert(value).inserted { return true }
    return false
  }
}
