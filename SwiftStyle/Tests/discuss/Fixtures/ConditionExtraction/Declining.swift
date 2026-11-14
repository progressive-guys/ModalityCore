// MARK: - Case BindingCondition
enum Examples {

  static func bindingCondition(_ values: [Int: Int], _ value: Int) -> Int {
    if let result = values[value + 1 + 2] { return result }
    return 0
  }
}

// MARK: - Case Conditions
enum Examples {

  static func conditionalTail(_ enabled: Bool, _ value: Int) -> Bool {
    if enabled, value + 1 + 2 > 0 { return true }
    return false
  }
}

// MARK: - Case ElseIfCondition
enum Examples {

  static func elseIfCondition(_ enabled: Bool, _ value: Int) -> Bool {
    if enabled { return true } else if value + 1 + 2 > 0 { return true }
    return false
  }
}

// MARK: - Case ImplicitResultCondition
enum Examples {

  static func implicitResultCondition(_ value: Int) -> Bool {
    if value + 1 + 2 > 0 {
      true
    } else {
      false
    }
  }
}

// MARK: - Case LabeledCondition
enum Examples {

  static func labeledCondition(_ value: Int) -> Bool {
    check: if value + 1 + 2 > 0 { break check }
    return false
  }
}

// MARK: - Case LaterConditionWithSyntaxCalls
import SwiftSyntax

enum Examples {

  static func repeatedCalls(_ enabled: Bool, _ make: () -> ExprSyntax) -> Bool {
    if enabled, make().is(IntegerLiteralExprSyntax.self) || make().is(FunctionCallExprSyntax.self) { return true }
    return false
  }
}

// MARK: - Case MacroCondition
enum Examples {

  static func macroCondition() -> Bool {
    if #line + 1 + 2 > 0 { return true }
    return false
  }
}

// MARK: - Case WhereCondition
enum Examples {

  static func whereCondition(_ values: [Int]) -> Bool {
    for value in values where value + 1 + 2 > 0 { return true }
    return false
  }
}
