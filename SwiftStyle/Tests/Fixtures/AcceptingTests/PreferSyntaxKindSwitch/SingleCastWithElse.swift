import SwiftSyntax

enum Examples {
  static func singleCheckWithFallback(_ next: () -> ExprSyntax) -> Int {
    if let item = next().as(FunctionCallExprSyntax.self) { return item.arguments.count } else { return 2 }
  }
}
