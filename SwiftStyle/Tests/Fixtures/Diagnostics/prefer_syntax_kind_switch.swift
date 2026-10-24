import SwiftSyntax

private extension ExprSyntax {
  func convert<Node: ExprSyntaxProtocol>(_ type: Node.Type) -> Node? { self.as(type) }
}

// MARK: - Accepted

private enum Accepted {
  static func select(_ input: ExprSyntax) -> Int {
    switch input.as(ExprSyntaxEnum.self) {
    case .functionCallExpr(let item): item.arguments.count
    case .subscriptCallExpr(let item): item.arguments.count
    default: 0
    }
  }

  static func optionalBinding(_ input: Int?) -> Int {
    if let item = input { return item }
    return 0
  }
}

// MARK: - Rejected

private enum Rejected {
  static func singleCheck(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    return 0
  }

  static func differentReceiver(_ input: ExprSyntax, _ second: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = second.as(SubscriptCallExprSyntax.self) { return 2 }
    return 0
  }

  static func extraCondition(_ input: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(SubscriptCallExprSyntax.self), condition { return 2 }
    return 0
  }

  static func interruption(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    print("step")
    if let item = input.as(SubscriptCallExprSyntax.self) { return 2 }
    return 0
  }

  static func nonterminal(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(SubscriptCallExprSyntax.self) { print("subscript") }
    return 0
  }

  static func otherMethod(_ input: ExprSyntax) -> Int {
    if let item = input.convert(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.convert(SubscriptCallExprSyntax.self) { return 2 }
    return 0
  }

  static func mixedFamilies(_ input: Syntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(ReturnStmtSyntax.self) { return 2 }
    return 0
  }

  static func duplicateType(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    return 0
  }

  static func select(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(SubscriptCallExprSyntax.self) { return 2 }
    return 0
  }

  static func threeChecks(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(SubscriptCallExprSyntax.self) { return 2 }
    if let item = input.as(MemberAccessExprSyntax.self) { return 3 }
    return 0
  }

  static func endingRun(_ input: ExprSyntax) {
    if let item = input.as(FunctionCallExprSyntax.self) { return }
    if let item = input.as(SubscriptCallExprSyntax.self) { return }
  }

  static func comments(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    // Continue checking the same expression.
    if let item = input.as(SubscriptCallExprSyntax.self) { return 2 }
    return 0
  }

  enum Failure: Error {
    case invalid
  }

  static func throwing(_ input: ExprSyntax) throws -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { throw Failure.invalid }
    if let item = input.as(SubscriptCallExprSyntax.self) { throw Failure.invalid }
    return 0
  }

  static func syntaxProjection(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return item.arguments.count }
    if let item = input.as(SubscriptCallExprSyntax.self) { return item.arguments.count }
    if let item = input.as(MemberAccessExprSyntax.self) { return item.declName.baseName.text.count }
    return 0
  }

  static func typeTest(_ input: ExprSyntax) -> Int {
    if input.is(FunctionCallExprSyntax.self) { return 1 }
    return 0
  }

  static func qualifiedType(_ input: ExprSyntax) -> Int {
    if let item = input.as(SwiftSyntax.FunctionCallExprSyntax.self) { return 1 }
    return 0
  }
}
