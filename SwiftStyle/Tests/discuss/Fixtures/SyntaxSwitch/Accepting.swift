// MARK: - Контексты отдельных проверок и преобразований SwiftSyntax (1)
enum Examples {

  // Дополнительные условия вокруг привязки типа
  static func singleCheckWithConditions(_ next: () -> ExprSyntax, flag: (String) -> Bool) -> Int {
    if flag("prefix"), let item = next().as(IntegerLiteralExprSyntax.self), flag("suffix") {
      return item.literal.text.count
    }

    return 0
  }

  // Проекция семейства типов SwiftSyntax
  static func familyProjection(_ input: Syntax) -> Int {
    if let expression = input.as(ExprSyntax.self) { return expression.description.count }
    return 0
  }

  // Необязательный объект проверки типа
  static func optionalReceiver(_ input: ExprSyntax?) -> Bool {
    if input?.is(IntegerLiteralExprSyntax.self) == nil { return true }
    return false
  }

  // Обычная привязка значения
  static func optionalBinding(_ input: Int?) -> Int {
    if let item = input { return item }
    return 0
  }
}

// MARK: - Контексты отдельных проверок и преобразований SwiftSyntax (2)
enum Examples {

  // Полное имя проверяемого типа
  static func qualifiedType(_ input: ExprSyntax) -> Int {
    if let item = input.as(SwiftSyntax.FunctionCallExprSyntax.self) { return 1 }
    return 0
  }

  // Одиночное приведение типа
  static func singleCheck(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    return 0
  }

  // Одиночная проверка типа
  static func typeTest(_ input: ExprSyntax) -> Int {
    if input.is(FunctionCallExprSyntax.self) { return 1 }
    return 0
  }
}

// MARK: - Пользовательский метод преобразования
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
