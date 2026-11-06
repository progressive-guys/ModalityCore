enum Examples {

  static func typeSwitch(_ input: Any) -> Int {
    switch input {
    case let item as String: return item.count
    case is Int: return 2
    case is Bool: return 3
    default: return 0
    }
  }
}
