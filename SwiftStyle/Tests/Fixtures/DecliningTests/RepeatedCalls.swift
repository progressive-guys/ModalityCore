import SwiftSyntax

enum Examples {

  static func repeatedCalls(_ enabled: Bool, _ make: () -> ExprSyntax) -> Bool {
    if enabled, make().is(IntegerLiteralExprSyntax.self) || make().is(FunctionCallExprSyntax.self) { return true }
    return false
  }
}
