// MARK: - Input
import SwiftSyntax

enum Examples {

  static func complexPredicate(_ value: Int, _ limit: Int, _ values: [Int]) -> Bool {
    if values.contains(where: { $0 > 0 && $0 < limit && $0 != value }) { return true }
    return false
  }

  static func commentInCondition(_ value: Int) -> Bool {
    if value + /* offset */ 1 + 2 > 0 { return true }
    return false
  }

  static func select(_ value: Int) -> Bool { value > 0 }
  static func select(_ value: Int) -> Int { value }

  static func contextualBool(_ value: Int) -> Bool {
    if select(value + 1 + 2) { return true }
    return false
  }

  static func guardFirstCondition(_ value: Int, _ enabled: Bool) -> Bool {
    guard value + 1 + 2 > 0, enabled else { return false }
    return true
  }

  static func ifWithElse(_ input: Int) -> Bool {
    let value = input
    if value + 1 + 2 > 0 { return true } else { return false }
  }

  static func loopBody(_ values: [Int]) -> Bool {
    for value in values {
      if value + 1 + 2 > 0 { return true }
    }

    return false
  }

  static func multipleArithmetic(_ value: Int, _ offset: Int, _ limit: Int) -> Bool {
    if value + offset + 1 > limit { return true }
    return false
  }

  static func nameCollision(_ matchesCondition: Int, _ matchesCondition2: Int) -> Bool {
    if matchesCondition + matchesCondition2 + 1 > 0 { return true }
    return false
  }

  static func nestedArithmetic(_ value: Int, _ offset: Int) -> Bool {
    if abs(abs(value + offset + 1)) > 0 { return true }
    return false
  }

  static func nestedOverLimit(_ text: String) -> Bool {
    if text.hasPrefix("0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345".lowercased()) { return true }
    return false
  }

  static func nestedClosure(_ values: [Int]) -> Bool {
    if values.contains(where: { value in values.contains(where: { $0 == value }) }) { return true }
    return false
  }

  static func receiverOrder(_ receiver: () -> String, _ argument: () -> String) -> Bool {
    if receiver().hasPrefix(argument()) { return true }
    return false
  }

  static func repeatedCalls(_ make: () -> ExprSyntax) -> Bool {
    if make().is(IntegerLiteralExprSyntax.self) || make().is(FunctionCallExprSyntax.self) { return true }
    return false
  }

  static func repeatedReceiverCalls(_ receiver: () -> String) -> Bool {
    if receiver().hasPrefix("a") || receiver().hasPrefix("b") { return true }
    return false
  }

  static func shortCircuit(_ enabled: Bool, _ receiver: () -> String, _ argument: () -> String) -> Bool {
    if enabled && receiver().hasPrefix(argument()) { return true }
    return false
  }

  static func throwingCondition(_ receiver: () throws -> String, _ argument: () throws -> String) throws -> Bool {
    if try receiver().hasPrefix(argument()) { return true }
    return false
  }

  static func awaitedCondition(_ receiver: () async -> String, _ argument: () async -> String) async -> Bool {
    if await receiver().hasPrefix(argument()) { return true }
    return false
  }
}

// MARK: - Output
import SwiftSyntax

enum Examples {

  static func complexPredicate(_ value: Int, _ limit: Int, _ values: [Int]) -> Bool {
    let matchesCondition3: Swift.Bool = values.contains(where: { $0 > 0 && $0 < limit && $0 != value })
    if matchesCondition3 { return true }
    return false
  }

  static func commentInCondition(_ value: Int) -> Bool {
    let matchesCondition4: Swift.Bool = value + /* offset */ 1 + 2 > 0
    if matchesCondition4 { return true }
    return false
  }

  static func select(_ value: Int) -> Bool { value > 0 }
  static func select(_ value: Int) -> Int { value }

  static func contextualBool(_ value: Int) -> Bool {
    let matchesCondition5: Swift.Bool = select(value + 1 + 2)
    if matchesCondition5 { return true }
    return false
  }

  static func guardFirstCondition(_ value: Int, _ enabled: Bool) -> Bool {
    let matchesCondition6: Swift.Bool = value + 1 + 2 > 0
    guard matchesCondition6, enabled else { return false }
    return true
  }

  static func ifWithElse(_ input: Int) -> Bool {
    let value = input
    let matchesCondition7: Swift.Bool = value + 1 + 2 > 0
    if matchesCondition7 { return true } else { return false }
  }

  static func loopBody(_ values: [Int]) -> Bool {
    for value in values {
      let matchesCondition8: Swift.Bool = value + 1 + 2 > 0
      if matchesCondition8 { return true }
    }

    return false
  }

  static func multipleArithmetic(_ value: Int, _ offset: Int, _ limit: Int) -> Bool {
    let matchesCondition9: Swift.Bool = value + offset + 1 > limit
    if matchesCondition9 { return true }
    return false
  }

  static func nameCollision(_ matchesCondition: Int, _ matchesCondition2: Int) -> Bool {
    let matchesCondition10: Swift.Bool = matchesCondition + matchesCondition2 + 1 > 0
    if matchesCondition10 { return true }
    return false
  }

  static func nestedArithmetic(_ value: Int, _ offset: Int) -> Bool {
    let matchesCondition11: Swift.Bool = abs(abs(value + offset + 1)) > 0
    if matchesCondition11 { return true }
    return false
  }

  static func nestedOverLimit(_ text: String) -> Bool {
    let matchesCondition12: Swift.Bool = text.hasPrefix("0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345".lowercased())
    if matchesCondition12 { return true }
    return false
  }

  static func nestedClosure(_ values: [Int]) -> Bool {
    let matchesCondition13: Swift.Bool = values.contains(where: { value in values.contains(where: { $0 == value }) })
    if matchesCondition13 { return true }
    return false
  }

  static func receiverOrder(_ receiver: () -> String, _ argument: () -> String) -> Bool {
    let matchesCondition14: Swift.Bool = receiver().hasPrefix(argument())
    if matchesCondition14 { return true }
    return false
  }

  static func repeatedCalls(_ make: () -> ExprSyntax) -> Bool {
    let matchesCondition15: Swift.Bool = make().is(IntegerLiteralExprSyntax.self) || make().is(FunctionCallExprSyntax.self)
    if matchesCondition15 { return true }
    return false
  }

  static func repeatedReceiverCalls(_ receiver: () -> String) -> Bool {
    let matchesCondition16: Swift.Bool = receiver().hasPrefix("a") || receiver().hasPrefix("b")
    if matchesCondition16 { return true }
    return false
  }

  static func shortCircuit(_ enabled: Bool, _ receiver: () -> String, _ argument: () -> String) -> Bool {
    let matchesCondition17: Swift.Bool = enabled && receiver().hasPrefix(argument())
    if matchesCondition17 { return true }
    return false
  }

  static func throwingCondition(_ receiver: () throws -> String, _ argument: () throws -> String) throws -> Bool {
    let matchesCondition18: Swift.Bool = try receiver().hasPrefix(argument())
    if matchesCondition18 { return true }
    return false
  }

  static func awaitedCondition(_ receiver: () async -> String, _ argument: () async -> String) async -> Bool {
    let matchesCondition19: Swift.Bool = await receiver().hasPrefix(argument())
    if matchesCondition19 { return true }
    return false
  }
}
