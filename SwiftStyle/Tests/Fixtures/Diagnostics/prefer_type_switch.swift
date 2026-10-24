import SwiftSyntax

private protocol Value { var value: String { get } }
private class Base {}
private final class First: Base, Value { let value = "bird" }
private final class Second: Base {}
private enum Failure: Error { case unsupported }

// MARK: - Accepted

private enum Accepted {
  static func singleCheck(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    return 0
  }

  static func differentReceiver(_ input: Any, _ second: Any) -> Int {
    if input is String { return 1 }
    if second is Bool { return 3 }
    return 0
  }

  static func extraCondition(_ input: Any, _ condition: Bool) -> Int {
    if input is String { return 1 }
    if let item = input as? [Int], condition { return item.count }
    return 0
  }

  static func withElse(_ input: Any) -> Int {
    if input is String { return 1 }
    if input is Bool { return 3 } else { return 0 }
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
    if input is Bool { return 3 }
    return 0
  }

  static func repeatedCalls(_ make: () -> Any) -> Int {
    if make() is String { return 1 }
    if make() is Int { return 2 }
    if make() is Bool { return 3 }
    return 0
  }

  static func repeatedProperties(_ input: Box) -> Int {
    if input.value is String { return 1 }
    if input.value is Int { return 2 }
    if input.value is Bool { return 3 }
    return 0
  }

  static func duplicateType(_ input: Any) -> Int {
    if input is String { return 1 }
    if input is String { return 3 }
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

  static func syntaxProjection(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return item.arguments.count }
    if let item = input.as(SubscriptCallExprSyntax.self) { return item.arguments.count }
    if let item = input.as(MemberAccessExprSyntax.self) { return item.declName.baseName.text.count }
    return 0
  }

  static func typeSwitch(_ input: Any) -> Int {
    switch input {
    case let item as String: return item.count
    case is Int: return 2
    case is Bool: return 3
    default: return 0
    }
  }

  struct Box { var value: Any { "value" } }
}

// MARK: - Rejected

private enum Rejected {
  static func twoCasts(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    if let item = input as? Int { return item }
    return 0
  }

  static func twoTypeChecks(_ input: Any) -> Int {
    if input is String { return 1 }
    if input is Int { return 2 }
    return 0
  }

  static func twoMixedChecks(_ input: Any) -> Int {
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

  static func classChecks(_ input: Base) -> Int {
    if input is First { return 1 }
    if input is Second { return 2 }
    if input is any Value { return 3 }
    return 0
  }

  static func mixedChecks(_ input: Any) -> Int {
    if let item = input as? First { return item.value.count }
    if input is Second { return 2 }
    if let item = input as? any Value { return item.value.count }
    return 0
  }

  static func throwsFromEachBranch(_ input: Any) throws -> Int {
    if input is String { throw Failure.unsupported }
    if input is Int { throw Failure.unsupported }
    if input is Bool { throw Failure.unsupported }
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
    if input is Bool { return 3 }
    return 0
  }
}
