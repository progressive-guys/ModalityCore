import SwiftSyntax

enum Examples {

  static func singleCheck(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    return 0
  }
}
