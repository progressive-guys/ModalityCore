import SwiftSyntax
import SwiftOperators

extension InfixOperatorExprSyntax {

  /// Identifies plain assignment and the standard compound assignment operators.
  var isAssignmentOperation: Bool {
    `operator`.is(AssignmentExprSyntax.self)
      || OperatorTable.standardOperators.infixOperator(named: `operator`.trimmedDescription)?.precedenceGroup
      == "AssignmentPrecedence"
  }
}
