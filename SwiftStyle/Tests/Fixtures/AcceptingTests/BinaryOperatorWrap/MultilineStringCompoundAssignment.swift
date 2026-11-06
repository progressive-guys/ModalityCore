enum Examples {

  static func multilineStringAssignment() -> String {
    var value = ""
    value +=
      """
      first
      second
      """
    return value
  }
}
