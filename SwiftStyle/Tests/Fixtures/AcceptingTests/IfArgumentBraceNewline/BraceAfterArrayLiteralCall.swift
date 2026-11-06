enum Examples {

  static func arrayLiteral(_ value: String) -> Bool {
    if [
      "first", "second"
    ].contains(value)
    { return true }

    return false
  }
}
