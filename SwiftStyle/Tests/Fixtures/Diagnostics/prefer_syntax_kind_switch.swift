private struct ExprSyntax {
  func `as`<Node>(_ type: Node.Type) -> Node? { nil }
  func convert<Node>(_ type: Node.Type) -> Node? { nil }
}
private struct FunctionCallExprSyntax {}
private struct SubscriptCallExprSyntax {}
private struct MemberAccessExprSyntax {}
private struct ReturnStmtSyntax {}

// MARK: - Accepted

private enum Accepted {
  static func select(_ expression: ExprSyntax, _ other: ExprSyntax, _ ready: Bool) -> Int {
    if let node = expression.as(FunctionCallExprSyntax.self) { return 1 }
    if let node = expression.as(SubscriptCallExprSyntax.self) { return 2 }
    return 0
  }
}

// MARK: - Rejected

private enum Rejected {
  static func select(_ expression: ExprSyntax, _ other: ExprSyntax, _ ready: Bool) -> Int {
    if let node = expression.as(FunctionCallExprSyntax.self) { return 1 }
    if let node = expression.as(SubscriptCallExprSyntax.self) { return 2 }
    if let node = expression.as(MemberAccessExprSyntax.self) { return 3 }
    return 0
  }
}

// MARK: - DifferentReceiver

private enum DifferentReceiver {
  static func select(_ expression: ExprSyntax, _ other: ExprSyntax, _ ready: Bool) -> Int {
    if let node = expression.as(FunctionCallExprSyntax.self) { return 1 }
    if let node = expression.as(SubscriptCallExprSyntax.self) { return 2 }
    if let node = other.as(MemberAccessExprSyntax.self) { return 3 }
    return 0
  }
}

// MARK: - ExtraCondition

private enum ExtraCondition {
  static func select(_ expression: ExprSyntax, _ other: ExprSyntax, _ ready: Bool) -> Int {
    if let node = expression.as(FunctionCallExprSyntax.self) { return 1 }
    if let node = expression.as(SubscriptCallExprSyntax.self) { return 2 }
    if let node = expression.as(MemberAccessExprSyntax.self), ready { return 3 }
    return 0
  }
}

// MARK: - Interruption

private enum Interruption {
  static func select(_ expression: ExprSyntax, _ other: ExprSyntax, _ ready: Bool) -> Int {
    if let node = expression.as(FunctionCallExprSyntax.self) { return 1 }
    if let node = expression.as(SubscriptCallExprSyntax.self) { return 2 }
    print("step")
    if let node = expression.as(MemberAccessExprSyntax.self) { return 3 }
    return 0
  }
}

// MARK: - Nonterminal

private enum Nonterminal {
  static func select(_ expression: ExprSyntax, _ other: ExprSyntax, _ ready: Bool) -> Int {
    if let node = expression.as(FunctionCallExprSyntax.self) { return 1 }
    if let node = expression.as(SubscriptCallExprSyntax.self) { return 2 }
    if let node = expression.as(MemberAccessExprSyntax.self) { print("member") }
    return 0
  }
}

// MARK: - OtherMethod

private enum OtherMethod {
  static func select(_ expression: ExprSyntax, _ other: ExprSyntax, _ ready: Bool) -> Int {
    if let node = expression.convert(FunctionCallExprSyntax.self) { return 1 }
    if let node = expression.convert(SubscriptCallExprSyntax.self) { return 2 }
    if let node = expression.convert(MemberAccessExprSyntax.self) { return 3 }
    return 0
  }
}

// MARK: - MixedFamilies

private enum MixedFamilies {
  static func select(_ expression: ExprSyntax, _ other: ExprSyntax, _ ready: Bool) -> Int {
    if let node = expression.as(FunctionCallExprSyntax.self) { return 1 }
    if let node = expression.as(SubscriptCallExprSyntax.self) { return 2 }
    if let node = expression.as(ReturnStmtSyntax.self) { return 3 }
    return 0
  }
}

// MARK: - DuplicateType

private enum DuplicateType {
  static func select(_ expression: ExprSyntax, _ other: ExprSyntax, _ ready: Bool) -> Int {
    if let node = expression.as(FunctionCallExprSyntax.self) { return 1 }
    if let node = expression.as(SubscriptCallExprSyntax.self) { return 2 }
    if let node = expression.as(FunctionCallExprSyntax.self) { return 1 }
    return 0
  }
}

// MARK: - Comments

private enum Comments {
  static func select(_ expression: ExprSyntax, _ other: ExprSyntax, _ ready: Bool) -> Int {
    if let node = expression.as(FunctionCallExprSyntax.self) { return 1 }
    // Continue checking the same expression.
    if let node = expression.as(SubscriptCallExprSyntax.self) { return 2 }
    if let node = expression.as(MemberAccessExprSyntax.self) { return 3 }
    return 0
  }
}

// MARK: - Throws

private enum Throws {
  enum Failure: Error {
    case invalid
  }

  static func select(_ expression: ExprSyntax) throws -> Int {
    if let node = expression.as(FunctionCallExprSyntax.self) { throw Failure.invalid }
    if let node = expression.as(SubscriptCallExprSyntax.self) { throw Failure.invalid }
    if let node = expression.as(MemberAccessExprSyntax.self) { throw Failure.invalid }
    return 0
  }
}
