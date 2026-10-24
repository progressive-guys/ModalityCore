import SwiftSyntax

private extension ExprSyntax {
  func convert<Node: ExprSyntaxProtocol>(_ type: Node.Type) -> Node? { self.as(type) }
}

// MARK: - Accepted

private enum Accepted {
  static func nativeChecks(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    if input is Int { return 2 }
    if input is Bool { return 3 }
    return 0
  }

  static func select(_ input: ExprSyntax, _ second: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    return 0
  }
}

// MARK: - Rejected

private enum Rejected {
  static func twoChecks(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return item.arguments.count }
    if let item = input.as(SubscriptCallExprSyntax.self) { return item.arguments.count }
    return 0
  }

  static func select(_ input: ExprSyntax, _ second: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(SubscriptCallExprSyntax.self) { return 2 }
    if let item = input.as(MemberAccessExprSyntax.self) { return 3 }
    return 0
  }

  static func withComments(_ input: ExprSyntax, _ second: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    // Continue checking the same expression.
    if let item = input.as(SubscriptCallExprSyntax.self) { return 2 }
    if let item = input.as(MemberAccessExprSyntax.self) { return 3 }
    return 0
  }

  enum Failure: Error {
    case invalid
  }

  static func throwingChecks(_ input: ExprSyntax) throws -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { throw Failure.invalid }
    if let item = input.as(SubscriptCallExprSyntax.self) { throw Failure.invalid }
    if let item = input.as(MemberAccessExprSyntax.self) { throw Failure.invalid }
    return 0
  }
}

// MARK: - DifferentReceiver

private enum DifferentReceiver {
  static func select(_ input: ExprSyntax, _ second: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = second.as(MemberAccessExprSyntax.self) { return 3 }
    return 0
  }
}

// MARK: - ExtraCondition

private enum ExtraCondition {
  static func select(_ input: ExprSyntax, _ second: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(MemberAccessExprSyntax.self), condition { return 3 }
    return 0
  }
}

// MARK: - Interruption

private enum Interruption {
  static func select(_ input: ExprSyntax, _ second: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    print("step")
    if let item = input.as(MemberAccessExprSyntax.self) { return 3 }
    return 0
  }
}

// MARK: - Nonterminal

private enum Nonterminal {
  static func select(_ input: ExprSyntax, _ second: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(MemberAccessExprSyntax.self) { print("member") }
    return 0
  }
}

// MARK: - OtherMethod

private enum OtherMethod {
  static func select(_ input: ExprSyntax, _ second: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.convert(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.convert(SubscriptCallExprSyntax.self) { return 2 }
    if let item = input.convert(MemberAccessExprSyntax.self) { return 3 }
    return 0
  }
}

// MARK: - MixedFamilies

private enum MixedFamilies {
  static func select(_ input: Syntax, _ second: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(ReturnStmtSyntax.self) { return 3 }
    return 0
  }
}

// MARK: - DuplicateType

private enum DuplicateType {
  static func select(_ input: ExprSyntax, _ second: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    return 0
  }
}
