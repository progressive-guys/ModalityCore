import SwiftSyntax

enum Examples {

  static func differentReceiver(_ input: ExprSyntax, _ second: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = second.as(SubscriptCallExprSyntax.self) { return 2 }
    return 0
  }
}
