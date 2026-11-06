import SwiftSyntax

enum Examples {

  static func qualifiedType(_ input: ExprSyntax) -> Int {
    if let item = input.as(SwiftSyntax.FunctionCallExprSyntax.self) { return 1 }
    return 0
  }
}
