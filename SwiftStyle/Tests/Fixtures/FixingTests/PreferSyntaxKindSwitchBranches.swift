// MARK: - Input
import SwiftSyntax

enum Examples {
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

  static func elseIfChecks(_ input: ExprSyntax) -> Int {
    if input.is(FunctionCallExprSyntax.self) {
      return 1
    } else if input.is(SubscriptCallExprSyntax.self) {
      return 2
    }
    return 0
  }

  static func conditionChecks(_ input: ExprSyntax) -> Int {
    if input.is(FunctionCallExprSyntax.self) || input.is(SubscriptCallExprSyntax.self) { return 1 }
    return 0
  }
}

// MARK: - Output
import SwiftSyntax

enum Examples {

  static func select(_ input: ExprSyntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item):
      return 2

    default:
      break
    }

    return 0
  }

  static func threeChecks(_ input: ExprSyntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item):
      return 2

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .memberAccessExpr(let item):
      return 3

    default:
      break
    }

    return 0
  }

  static func endingRun(_ input: ExprSyntax) {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item):
      return

    default:
      break
    }
  }

  static func elseIfChecks(_ input: ExprSyntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr:
      return 1

    default:
      if input.is(SubscriptCallExprSyntax.self) {
      return 2
    }
    }

    return 0
  }

  static func conditionChecks(_ input: ExprSyntax) -> Int {
    if ({ () -> Bool in
      switch (Syntax(input).as(SyntaxEnum.self)) {
      case .functionCallExpr: return true
      default: return false
      }
    }()) || ({ () -> Bool in
      switch (Syntax(input).as(SyntaxEnum.self)) {
      case .subscriptCallExpr: return true
      default: return false
      }
    }()) { return 1 }

    return 0
  }
}
