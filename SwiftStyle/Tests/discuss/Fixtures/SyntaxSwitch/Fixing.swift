// MARK: - Проверки SwiftSyntax превращаются в отдельные switch с условием where

enum Example {

  static func extraCondition(_ input: ExprSyntax, _ condition: Bool) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(SubscriptCallExprSyntax.self), condition { return 2 }
    return 0
  }
}

/// Output

enum Example {

  static func extraCondition(_ input: ExprSyntax, _ condition: Bool) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item) where (condition):
      return 2

    default:
      break
    }

    return 0
  }
}

// MARK: - Проверки SwiftSyntax превращаются в отдельные switch, комментарий остаётся между ними

enum Example {

  static func comments(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    // Continue checking the same expression.
    if let item = input.as(SubscriptCallExprSyntax.self) { return 2 }
    return 0
  }
}

/// Output

enum Example {

  static func comments(_ input: ExprSyntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    // Continue checking the same expression.
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item):
      return 2

    default:
      break
    }

    return 0
  }
}

// MARK: - Проверки разных семейств SwiftSyntax превращаются в отдельные switch

enum Example {

  static func mixedFamilies(_ input: Syntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(ReturnStmtSyntax.self) { return 2 }
    return 0
  }
}

/// Output

enum Example {

  static func mixedFamilies(_ input: Syntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .returnStmt(let item):
      return 2

    default:
      break
    }

    return 0
  }
}

// MARK: - Отдельные switch сохраняют связанные значения SwiftSyntax и чтение их свойств

enum Example {

  static func syntaxProjection(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return item.arguments.count }
    if let item = input.as(SubscriptCallExprSyntax.self) { return item.arguments.count }
    if let item = input.as(MemberAccessExprSyntax.self) { return item.declName.baseName.text.count }
    return 0
  }
}

/// Output

enum Example {

  static func syntaxProjection(_ input: ExprSyntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return item.arguments.count

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item):
      return item.arguments.count

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .memberAccessExpr(let item):
      return item.declName.baseName.text.count

    default:
      break
    }

    return 0
  }
}

// MARK: - Отдельные switch сохраняют throw при успешном приведении узла SwiftSyntax

enum Example {

  enum Failure: Error {
    case invalid
  }

  static func throwing(_ input: ExprSyntax) throws -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { throw Failure.invalid }
    if let item = input.as(SubscriptCallExprSyntax.self) { throw Failure.invalid }
    return 0
  }
}

/// Output

enum Example {

  enum Failure: Error {
    case invalid
  }

  static func throwing(_ input: ExprSyntax) throws -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      throw Failure.invalid

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item):
      throw Failure.invalid

    default:
      break
    }

    return 0
  }
}

// MARK: - Два приведения SwiftSyntax превращаются в два отдельных switch

enum Example {

  static func select(_ input: ExprSyntax) -> Int {
    if let item = input.as(FunctionCallExprSyntax.self) { return 1 }
    if let item = input.as(SubscriptCallExprSyntax.self) { return 2 }
    return 0
  }
}

/// Output

enum Example {

  static func select(_ input: ExprSyntax) -> Int {
    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .functionCallExpr(let item):
      return 1

    default:
      break
    }

    switch (Syntax(input).as(SyntaxEnum.self)) {
    case .subscriptCallExpr(let item):
      return 2

    default:
      break
    }

    return 0
  }
}
