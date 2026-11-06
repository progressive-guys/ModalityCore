import SwiftSyntax

enum Examples {

  static func select(_ input: ExprSyntax) -> Int {
    switch input.as(ExprSyntaxEnum.self) {
    case .functionCallExpr(let item): item.arguments.count
    case .subscriptCallExpr(let item): item.arguments.count
    default: 0
    }
  }
}
