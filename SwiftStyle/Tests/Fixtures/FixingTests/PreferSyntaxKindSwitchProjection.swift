// MARK: - Input
import SwiftSyntax

enum Examples {
  enum Failure: Error {
    case invalid
  }

  static func mixedFamilies(_ input: Syntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(ReturnStmtSyntax.self) { return 2 }
    return 0
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
}

// MARK: - Output
import SwiftSyntax

enum Examples {

  enum Failure: Error {
    case invalid
  }

  static func mixedFamilies(_ input: Syntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .returnStmt(let item):
      return 2

    default:
      break
    }

    return 0
  }

  static func syntaxProjection(_ input: ExprSyntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return item.arguments.count

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item):
      return item.arguments.count

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .memberAccessExpr(let item):
      return item.declName.baseName.text.count

    default:
      break
    }

    return 0
  }

  static func throwing(_ input: ExprSyntax) throws -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      throw Failure.invalid

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item):
      throw Failure.invalid

    default:
      break
    }

    return 0
  }
}
