enum Examples {

  static func multipleNestedCalls(_ first: Int, _ second: Int) -> Bool {
    if max(abs(first), abs(second)) > 0 { return true }
    return false
  }
}
