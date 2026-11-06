import SwiftSyntax

enum Examples {

  static func interruption(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }

    print("step")

    if let item = input.as(SubscriptCallExprSyntax.self) { return 2 }

    return 0
  }
}
