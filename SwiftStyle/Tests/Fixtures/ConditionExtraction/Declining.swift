// MARK: - Условия, требующие ручного выноса выражения (1)
enum Examples {

  // Сложный индекс в optional-привязке не выносится автоматически
  static func bindingCondition(_ values: [Int: Int], _ value: Int) -> Int {
    if let result = values[value + 1 + 2] {
      return result
    }

    return 0
  }

  // Сложное выражение во втором условии не выносится автоматически
  static func conditionalTail(_ enabled: Bool, _ value: Int) -> Bool {
    if enabled, value + 1 + 2 > 0 {
      return true
    }

    return false
  }

  // Сложное условие else if не выносится автоматически
  static func elseIfCondition(_ enabled: Bool, _ value: Int) -> Bool {
    if enabled {
      return true
    } else if value + 1 + 2 > 0 {
      return true
    }

    return false
  }

  // Сложное условие if с неявным результатом не выносится автоматически
  static func implicitResultCondition(_ value: Int) -> Bool {
    if value + 1 + 2 > 0 {
      true
    } else {
      false
    }
  }
}

// MARK: - Условия, требующие ручного выноса выражения (2)
enum Examples {

  // Сложное условие инструкции с меткой не выносится автоматически
  static func labeledCondition(_ value: Int) -> Bool {
    check: if value + 1 + 2 > 0 { break check }
    return false
  }

  // Повторные вызовы SwiftSyntax после первого условия не выносятся автоматически
  static func repeatedCalls(_ enabled: Bool, _ make: () -> ExprSyntax) -> Bool {
    if enabled, make().is(IntegerLiteralExprSyntax.self) || make().is(FunctionCallExprSyntax.self) {
      return true
    }

    return false
  }

  // Условие с макросом не выносится автоматически
  static func macroCondition() -> Bool {
    if #line + 1 + 2 > 0 {
      return true
    }

    return false
  }

  // Сложное условие where не выносится автоматически
  static func whereCondition(_ values: [Int]) -> Bool {
    for value in values where value + 1 + 2 > 0 { return true }
    return false
  }
}
