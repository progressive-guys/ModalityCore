import SwiftSyntax

private extension ExprSyntax {
  func convert<Node: ExprSyntaxProtocol>(_ type: Node.Type) -> Node? { self.as(type) }
}

enum Examples {

  static func otherMethod(_ input: ExprSyntax) -> Int {
    if let item = input.convert(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.convert(SubscriptCallExprSyntax.self) { return 2 }
    return 0
  }
}
