enum Examples {

  static func singleTypeTest(_ input: Any) -> Bool {
    if input is String { return true }
    return false
  }
}
