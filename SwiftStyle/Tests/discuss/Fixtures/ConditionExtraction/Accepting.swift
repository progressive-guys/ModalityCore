// MARK: - Допустимые выражения в условиях и их области видимости (1)
enum Examples {

  // Условие после объявления с явным типом
  static func typedBinding(_ text: String) -> Bool {
    if let parsed: Int = Int(text), abs(abs(parsed)) > 0 { return true }
    return false
  }

  // Область видимости условия where у варианта switch
  static func caseWhere(_ value: Int) -> Bool {
    switch value {
    case let number where abs(abs(number)) > 0:
      return true

    default:
      return false
    }
  }
}

// MARK: - Допустимые выражения в условиях и их области видимости (2)
enum Examples {

  // Область видимости условия where у catch
  enum Failure: Error {
    case invalid
  }

  static func catchWhere() -> Bool {
    do {
      throw Failure.invalid
    } catch where String(describing: type(of: error)).isEmpty {
      return true
    } catch {
      return false
    }
  }

  // Короткий предикат-замыкание остаётся непосредственно в условии
  static func shortPredicate(_ values: [Int]) -> Bool {
    if values.contains(where: { $0 > 0 }) { return true }
    return false
  }

  // Комментарий внутри вызова в условии
  static func nestedComment(_ value: Int) -> Bool {
    if abs(/* input */ abs(value)) > 0 { return true }
    return false
  }
}

// MARK: - Допустимые выражения в условиях и их области видимости (3)
enum Examples {

  // Область видимости условия where у цикла for
  static func forWhere(_ values: [Int]) -> Void {
    for value in values where abs(abs(value)) > 0 {
      print(value)
    }
  }

  // Многострочный вызов в условии
  static func multilineNestedCall(_ value: Int) -> Bool {
    if abs(abs(
      value
    )) > 0 { return true }

    return false
  }

  // Результат вызова, изменяющего состояние, в условии
  static func apiInsertedResult(_ values: inout Set<Int>, _ value: Int) -> Bool {
    if values.insert(value).inserted { return true }
    return false
  }

  // Вызов необязательного значения в условии
  static func optionalCall(_ callback: (() -> Bool)?) -> Bool {
    if callback?() == true { return true }
    return false
  }
}

// MARK: - Допустимые выражения в условиях и их области видимости (4)
enum Examples {

  // Вложенные вызовы остаются в условии цикла repeat
  static func repeatExcluded(_ value: Int) {
    repeat {
      print(value)
    } while abs(abs(value)) > 0
  }

  // Короткое арифметическое выражение в условии
  static func simpleArithmetic(_ value: Int, _ offset: Int, _ limit: Int) -> Bool {
    if value + offset > limit { return true }
    return false
  }

  // Короткие вложенные вызовы остаются в условии guard
  static func guardNestedCall(_ value: Int) -> Bool {
    guard abs(abs(value)) > 0 else { return false }
    return true
  }

  // Короткие вложенные вызовы в условии
  static func deepShortCall(_ value: Int) -> Bool {
    if abs(abs(abs(value))) > 0 { return true }
    return false
  }
}

// MARK: - Допустимые выражения в условиях и их области видимости (5)
enum Examples {

  // Обращение по индексу в условии
  static func indexing(_ values: [Int], _ index: Int) -> Bool {
    if values[index] > 0 { return true }
    return false
  }

  // Вложенные вызовы остаются в условии цикла while
  static func whileExcluded(_ value: Int) {
    while abs(abs(value)) > 0 { return }
  }

  // Вложенный вызов длиной 120 символов остаётся в условии
  static func nestedAtLimit(_ text: String) -> Bool {
    if text.hasPrefix("012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234".lowercased()) { return true }
    return false
  }
}
