// MARK: - Input
import SwiftSyntax

enum Examples {
  static func extraCondition(_ input: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(SubscriptCallExprSyntax.self), condition { return 2 }
    return 0
  }

  static func nonterminal(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(SubscriptCallExprSyntax.self) { print("subscript") }
    return 0
  }

  static func duplicateType(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    return 0
  }

  static func comments(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    // Continue checking the same expression.
    if let item = input.as(SubscriptCallExprSyntax.self) { return 2 }
    return 0
  }
}

// MARK: - Output
import SwiftSyntax

enum Examples {

  static func extraCondition(_ input: ExprSyntax, _ condition: Bool) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item) where (condition):
      return 2

    default:
      break
    }

    return 0
  }

  static func nonterminal(_ input: ExprSyntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item):
      print("subscript")

    default:
      break
    }

    return 0
  }

  static func duplicateType(_ input: ExprSyntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    return 0
  }

  static func comments(_ input: ExprSyntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    // Continue checking the same expression.
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item):
      return 2

    default:
      break
    }

    return 0
  }
}
