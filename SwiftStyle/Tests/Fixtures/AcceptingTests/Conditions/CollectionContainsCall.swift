enum Examples {

  static func apiResult(_ value: Int, _ values: [Int]) -> Bool {
    if values.contains(value) { return true }
    return false
  }
}
