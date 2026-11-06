// MARK: - Input
enum Examples {
  static func extraCondition(_ input: Any, _ condition: Bool) -> Int {
    if input is String { return 1 }
    if let item = input as? [Int], condition { return item.count }
    return 0
  }

  static func negatedCheck(_ input: Any) -> Int {
    if input is String { return 1 }
    if !(input is Bool) { return 3 }
    return 0
  }

  static func mutableBinding(_ input: Any) -> Int {
    if var item = input as? String {
      item.append("suffix")
      return item.count
    }
    if input is Int { return 2 }
    return 0
  }

  static func nonterminal(_ input: Any) -> Int {
    if input is String { print("string") }
    if input is Int { print("integer") }
    if input is Bool { print("boolean") }
    return 0
  }

  static func duplicateType(_ input: Any) -> Int {
    if input is String { return 1 }
    if input is String { return 2 }
    return 0
  }
}

// MARK: - Output
enum Examples {

  static func extraCondition(_ input: Any, _ condition: Bool) -> Int {
    switch (input) {
    case is String:
      return 1

    default:
      break
    }

    switch (input) {
    case let item as [Int] where (condition):
      return item.count

    default:
      break
    }

    return 0
  }

  static func negatedCheck(_ input: Any) -> Int {
    switch (input) {
    case is String:
      return 1

    default:
      break
    }

    switch (input) {
    case is Bool:
      break

    default:
      return 3
    }

    return 0
  }

  static func mutableBinding(_ input: Any) -> Int {
    switch (input) {
    case var item as String:
      item.append("suffix")
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

  static func nonterminal(_ input: Any) -> Int {
    switch (input) {
    case is String:
      print("string")

    default:
      break
    }

    switch (input) {
    case is Int:
      print("integer")

    default:
      break
    }

    switch (input) {
    case is Bool:
      print("boolean")

    default:
      break
    }

    return 0
  }

  static func duplicateType(_ input: Any) -> Int {
    switch (input) {
    case is String:
      return 1

    default:
      break
    }

    switch (input) {
    case is String:
      return 2

    default:
      break
    }

    return 0
  }
}
