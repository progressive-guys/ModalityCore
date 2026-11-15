// MARK: - Условие с await выносится в отдельную константу
enum Example {

  static func awaitedCondition(_ receiver: () async -> String, _ argument: () async -> String) async -> Bool {
    if await receiver().hasPrefix(argument()) { return true }
    return false
  }
}

/// Output
enum Example {

  static func awaitedCondition(_ receiver: () async -> String, _ argument: () async -> String) async -> Bool {
    let matchesCondition: Swift.Bool = await receiver().hasPrefix(argument())
    if matchesCondition { return true }
    return false
  }
}

// MARK: - При выносе условия блочный комментарий сохраняется
enum Example {

  static func commentInCondition(_ value: Int) -> Bool {
    if value + /* offset */ 1 + 2 > 0 { return true }
    return false
  }
}

/// Output
enum Example {

  static func commentInCondition(_ value: Int) -> Bool {
    let matchesCondition: Swift.Bool = value + /* offset */ 1 + 2 > 0
    if matchesCondition { return true }
    return false
  }
}

// MARK: - Тип Bool у вынесенного условия сохраняет выбор перегрузки
enum Example {

  static func select(_ value: Int) -> Bool { value > 0 }

  static func select(_ value: Int) -> Int { value }

  static func contextualBool(_ value: Int) -> Bool {
    if select(value + 1 + 2) { return true }
    return false
  }
}

/// Output
enum Example {

  static func select(_ value: Int) -> Bool { value > 0 }

  static func select(_ value: Int) -> Int { value }

  static func contextualBool(_ value: Int) -> Bool {
    let matchesCondition: Swift.Bool = select(value + 1 + 2)
    if matchesCondition { return true }
    return false
  }
}

// MARK: - Первое условие guard выносится перед проверкой
enum Example {

  static func guardFirstCondition(_ value: Int, _ enabled: Bool) -> Bool {
    guard value + 1 + 2 > 0, enabled else { return false }
    return true
  }
}

/// Output
enum Example {

  static func guardFirstCondition(_ value: Int, _ enabled: Bool) -> Bool {
    let matchesCondition: Swift.Bool = value + 1 + 2 > 0
    guard matchesCondition, enabled else { return false }
    return true
  }
}

// MARK: - Условие if выносится с сохранением ветки else
enum Example {

  static func ifWithElse(_ input: Int) -> Bool {
    let value = input
    if value + 1 + 2 > 0 { return true } else { return false }
  }
}

/// Output
enum Example {

  static func ifWithElse(_ input: Int) -> Bool {
    let value = input
    let matchesCondition: Swift.Bool = value + 1 + 2 > 0
    if matchesCondition { return true } else { return false }
  }
}

// MARK: - Условие выносится внутри тела цикла
enum Example {

  static func loopBody(_ values: [Int]) -> Bool {
    for value in values {
      if value + 1 + 2 > 0 { return true }
    }

    return false
  }
}

/// Output
enum Example {

  static func loopBody(_ values: [Int]) -> Bool {
    for value in values {
      let matchesCondition: Swift.Bool = value + 1 + 2 > 0
      if matchesCondition { return true }
    }

    return false
  }
}

// MARK: - Имя вынесенного условия не совпадает с существующими параметрами
enum Example {

  static func nameCollision(_ matchesCondition: Int, _ matchesCondition2: Int) -> Bool {
    if matchesCondition + matchesCondition2 + 1 > 0 { return true }
    return false
  }
}

/// Output
enum Example {

  static func nameCollision(_ matchesCondition: Int, _ matchesCondition2: Int) -> Bool {
    let matchesCondition3: Swift.Bool = matchesCondition + matchesCondition2 + 1 > 0
    if matchesCondition3 { return true }
    return false
  }
}

// MARK: - Условие с вложенными замыканиями выносится целиком
enum Example {

  static func nestedClosure(_ values: [Int]) -> Bool {
    if values.contains(where: { value in values.contains(where: { $0 == value }) }) { return true }
    return false
  }
}

/// Output
enum Example {

  static func nestedClosure(_ values: [Int]) -> Bool {
    let matchesCondition: Swift.Bool = values.contains(where: { value in values.contains(where: { $0 == value }) })
    if matchesCondition { return true }
    return false
  }
}

// MARK: - При выносе условия сохраняется порядок вычисления объекта и аргумента
enum Example {

  static func receiverOrder(_ receiver: () -> String, _ argument: () -> String) -> Bool {
    if receiver().hasPrefix(argument()) { return true }
    return false
  }
}

/// Output
enum Example {

  static func receiverOrder(_ receiver: () -> String, _ argument: () -> String) -> Bool {
    let matchesCondition: Swift.Bool = receiver().hasPrefix(argument())
    if matchesCondition { return true }
    return false
  }
}

// MARK: - При выносе условия сохраняются повторные вызовы объекта
enum Example {

  static func repeatedReceiverCalls(_ receiver: () -> String) -> Bool {
    if receiver().hasPrefix("a") || receiver().hasPrefix("b") { return true }
    return false
  }
}

/// Output
enum Example {

  static func repeatedReceiverCalls(_ receiver: () -> String) -> Bool {
    let matchesCondition: Swift.Bool = receiver().hasPrefix("a") || receiver().hasPrefix("b")
    if matchesCondition { return true }
    return false
  }
}

// MARK: - Повторные вызовы SwiftSyntax сохраняются в вынесенном условии

enum Example {

  static func repeatedCalls(_ make: () -> ExprSyntax) -> Bool {
    if make().is(IntegerLiteralExprSyntax.self) || make().is(FunctionCallExprSyntax.self) { return true }
    return false
  }
}

/// Output

enum Example {

  static func repeatedCalls(_ make: () -> ExprSyntax) -> Bool {
    let matchesCondition: Swift.Bool = make().is(IntegerLiteralExprSyntax.self) || make().is(FunctionCallExprSyntax.self)
    if matchesCondition { return true }
    return false
  }
}

// MARK: - При выносе условия сохраняется короткое замыкание оператора &&
enum Example {

  static func shortCircuit(_ enabled: Bool, _ receiver: () -> String, _ argument: () -> String) -> Bool {
    if enabled && receiver().hasPrefix(argument()) { return true }
    return false
  }
}

/// Output
enum Example {

  static func shortCircuit(_ enabled: Bool, _ receiver: () -> String, _ argument: () -> String) -> Bool {
    let matchesCondition: Swift.Bool = enabled && receiver().hasPrefix(argument())
    if matchesCondition { return true }
    return false
  }
}

// MARK: - Условие с try выносится в отдельную константу
enum Example {

  static func throwingCondition(_ receiver: () throws -> String, _ argument: () throws -> String) throws -> Bool {
    if try receiver().hasPrefix(argument()) { return true }
    return false
  }
}

/// Output
enum Example {

  static func throwingCondition(_ receiver: () throws -> String, _ argument: () throws -> String) throws -> Bool {
    let matchesCondition: Swift.Bool = try receiver().hasPrefix(argument())
    if matchesCondition { return true }
    return false
  }
}

// MARK: - Условие с вложенным вызовом длиной 121 символ выносится в константу
enum Example {

  static func nestedOverLimit(_ text: String) -> Bool {
    if text.hasPrefix("0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345".lowercased()) { return true }
    return false
  }
}

/// Output
enum Example {

  static func nestedOverLimit(_ text: String) -> Bool {
    let matchesCondition: Swift.Bool = text.hasPrefix("0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345".lowercased())
    if matchesCondition { return true }
    return false
  }
}
