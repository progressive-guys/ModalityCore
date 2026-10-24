// MARK: - Accepted

private enum Accepted {
  protocol Named { var name: String { get } }
  class Animal {}
  final class Bird: Animal, Named { let name = "bird" }
  final class Fish: Animal {}

  static func typeSwitch(_ input: Any) -> Int {
    switch input {
    case let item as String: return item.count
    case is Int: return 2
    case is Bool: return 3
    default: return 0
    }
  }

  struct Box { var value: Any { "value" } }

  static func optionalBinding(_ input: Int?) -> Int {
    if let item = input { return item }
    return 0
  }

  static func castInBody(_ input: Any, _ ready: Bool) -> String? {
    if ready { return input as? String }
    return nil
  }

  static func closurePredicate(_ values: [Any]) -> Bool {
    if values.contains(where: { $0 is Int }) { return true }
    return false
  }
}

// MARK: - Rejected

private enum Rejected {
  static func singleCheck(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    return 0
  }

  static func differentReceiver(_ input: Any, _ second: Any) -> Int {
    if input is String { return 1 }
    if second is Int { return 2 }
    return 0
  }

  static func extraCondition(_ input: Any, _ condition: Bool) -> Int {
    if input is String { return 1 }
    if let item = input as? [Int], condition { return item.count }
    return 0
  }

  static func withElse(_ input: Any) -> Int {
    if input is String { return 1 }
    if input is Int { return 2 } else { return 0 }
  }

  static func nonterminal(_ input: Any) -> Int {
    if input is String { print("string") }
    if input is Int { print("integer") }
    if input is Bool { print("boolean") }
    return 0
  }

  static func interruption(_ input: Any) -> Int {
    if input is String { return 1 }
    print("step")
    if input is Int { return 2 }
    return 0
  }

  static func repeatedCalls(_ make: () -> Any) -> Int {
    if make() is String { return 1 }
    if make() is Int { return 2 }
    if make() is Bool { return 3 }
    return 0
  }

  static func repeatedProperties(_ input: Accepted.Box) -> Int {
    if input.value is String { return 1 }
    if input.value is Int { return 2 }
    if input.value is Bool { return 3 }
    return 0
  }

  static func duplicateType(_ input: Any) -> Int {
    if input is String { return 1 }
    if input is String { return 2 }
    return 0
  }

  static func unconditionalCast(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    let item = input as Any
    if item is Bool { return 3 }
    return 0
  }

  static func negatedCheck(_ input: Any) -> Int {
    if input is String { return 1 }
    if !(input is Bool) { return 3 }
    return 0
  }

  enum Failure: Error { case unsupported }

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

  static func classChecks(_ input: Accepted.Animal) -> Int {
    if input is Accepted.Bird { return 1 }
    if input is Accepted.Fish { return 2 }
    if input is any Accepted.Named { return 3 }
    return 0
  }

  static func mixedChecks(_ input: Any) -> Int {
    if let item = input as? Accepted.Bird { return item.name.count }
    if input is Accepted.Fish { return 2 }
    if let item = input as? any Accepted.Named { return item.name.count }
    return 0
  }

  static func throwsFromEachBranch(_ input: Any) throws -> Int {
    if input is String { throw Failure.unsupported }
    if input is Int { throw Failure.unsupported }
    return 0
  }

  static func genericTypes(_ input: Any) -> Int {
    if let item = input as? [Swift.String] { return item.count }
    if let item = input as? Dictionary<String, Int> { return item.count }
    if let item = input as? Set<Int> { return item.count }
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

  static func nativeChecks(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    if input is Int { return 1 }
    if input is Bool { return 2 }
    return 0
  }
}
