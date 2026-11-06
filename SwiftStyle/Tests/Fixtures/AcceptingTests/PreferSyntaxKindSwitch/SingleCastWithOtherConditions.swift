import SwiftSyntax

enum Examples {

  static func singleCheckWithConditions(_ next: () -> ExprSyntax, flag: (String) -> Bool) -> Int {
    if flag("prefix"), let item = next().as(IntegerLiteralExprSyntax.self), flag("suffix") {
      return item.literal.text.count
    }

    return 0
  }
}
