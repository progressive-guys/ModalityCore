import SwiftSyntax

enum Examples {

  static func optionalReceiver(_ input: ExprSyntax?) -> Bool {
    if input?.is(IntegerLiteralExprSyntax.self) == nil { return true }
    return false
  }
}
