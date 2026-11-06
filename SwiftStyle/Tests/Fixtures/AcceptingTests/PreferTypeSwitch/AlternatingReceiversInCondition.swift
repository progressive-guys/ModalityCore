enum Examples {

  static func alternatingObjects(_ input: Any, _ second: Any) -> Bool {
    if input is String || second is String || input is Bool { return true }
    return false
  }
}
