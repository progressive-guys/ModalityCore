// MARK: - Input
enum Examples {
  static func twoChecks(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    if input is Int { return 2 }
    return 0
  }

  static func conditionalCasts(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    if let item = input as? Int { return item }
    if let item = input as? [Int] { return item.count }
    return 0
  }

  static func withElse(_ input: Any) -> Int {
    if input is String { return 1 }
    if input is Int { return 2 } else { return 0 }
  }

  static func elseIfChecks(_ input: Any) -> Int {
    if input is String {
      return 1
    } else if input is Int {
      return 2
    }
    return 0
  }

  static func conditionChecks(_ input: Any) -> Int {
    if input is String || input is Int { return 1 }
    return 0
  }
}

// MARK: - Output
enum Examples {

  static func twoChecks(_ input: Any) -> Int {
    switch (input) {
    case let item as String:
      return item.count

    default:
      break
    }

    switch (input) {
    case is Int:
      return 2

    default:
      break
    }

    return 0
  }

  static func conditionalCasts(_ input: Any) -> Int {
    switch (input) {
    case let item as String:
      return item.count

    default:
      break
    }

    switch (input) {
    case let item as Int:
      return item

    default:
      break
    }

    switch (input) {
    case let item as [Int]:
      return item.count

    default:
      break
    }

    return 0
  }

  static func withElse(_ input: Any) -> Int {
    switch (input) {
    case is String:
      return 1

    default:
      break
    }

    switch (input) {
    case is Int:
      return 2

    default:
      return 0
    }
  }

  static func elseIfChecks(_ input: Any) -> Int {
    switch (input) {
    case is String:
      return 1

    default:
      if input is Int {
      return 2
    }
    }

    return 0
  }

  static func conditionChecks(_ input: Any) -> Int {
    if ({ () -> Bool in
      switch (input) {
      case is String: return true
      default: return false
      }
    }()) || ({ () -> Bool in
      switch (input) {
      case is Int: return true
      default: return false
      }
    }()) { return 1 }

    return 0
  }
}
