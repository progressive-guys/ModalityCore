import SwiftSyntax

enum Examples {

  static func alternatingObjects(_ input: ExprSyntax, _ second: ExprSyntax) -> Bool {
    if input.is(FunctionCallExprSyntax.self) || second.is(FunctionCallExprSyntax.self) || input.is(SubscriptCallExprSyntax.self) { return true }
    return false
  }
}
