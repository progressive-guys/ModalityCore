import SwiftSyntax

enum Examples {

  static func typeTest(_ input: ExprSyntax) -> Int {
    if input.is(FunctionCallExprSyntax.self) { return 1 }
    return 0
  }
}
