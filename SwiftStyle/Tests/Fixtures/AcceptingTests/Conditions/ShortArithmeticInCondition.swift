enum Examples {

  static func simpleArithmetic(_ value: Int, _ offset: Int, _ limit: Int) -> Bool {
    if value + offset > limit { return true }
    return false
  }
}
