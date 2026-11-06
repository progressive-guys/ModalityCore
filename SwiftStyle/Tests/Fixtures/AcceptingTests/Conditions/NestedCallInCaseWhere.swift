enum Examples {

  static func caseWhere(_ value: Int) -> Bool {
    switch value {
    case let number where abs(abs(number)) > 0:
      return true

    default:
      return false
    }
  }
}
