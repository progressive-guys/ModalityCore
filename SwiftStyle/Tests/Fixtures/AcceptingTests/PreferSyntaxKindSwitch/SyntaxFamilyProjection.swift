import SwiftSyntax

enum Examples {

  static func familyProjection(_ input: Syntax) -> Int {
    if let expression = input.as(ExprSyntax.self) { return expression.description.count }
    return 0
  }
}
