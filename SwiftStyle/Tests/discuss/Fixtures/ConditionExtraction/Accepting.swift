// MARK: - Условие после объявления с явным типом
enum Examples {

  static func typedBinding(_ text: String) -> Bool {
    if let parsed: Int = Int(text), abs(abs(parsed)) > 0 { return true }
    return false
  }
}

// MARK: - Область видимости условия where у варианта switch
enum Examples {

  static func caseWhere(_ value: Int) -> Bool {
    switch value {
    case let number where abs(abs(number)) > 0:
      return true

    default:
      return false
    }
  }
}

// MARK: - Область видимости условия where у catch
enum Examples {

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
}

// MARK: - Короткий предикат-замыкание остаётся непосредственно в условии
enum Examples {

  static func shortPredicate(_ values: [Int]) -> Bool {
    if values.contains(where: { $0 > 0 }) { return true }
    return false
  }
}

// MARK: - Комментарий внутри вызова в условии
enum Examples {

  static func nestedComment(_ value: Int) -> Bool {
    if abs(/* input */ abs(value)) > 0 { return true }
    return false
  }
}

// MARK: - Область видимости условия where у цикла for
enum Examples {

  static func forWhere(_ values: [Int]) -> Void {
    for value in values where abs(abs(value)) > 0 {
      print(value)
    }
  }
}

// MARK: - Многострочный вызов в условии
enum Examples {

  static func multilineNestedCall(_ value: Int) -> Bool {
    if abs(abs(
      value
    )) > 0 { return true }

    return false
  }
}

// MARK: - Результат вызова, изменяющего состояние, в условии
enum Examples {

  static func apiInsertedResult(_ values: inout Set<Int>, _ value: Int) -> Bool {
    if values.insert(value).inserted { return true }
    return false
  }
}

// MARK: - Вызов необязательного значения в условии
enum Examples {

  static func optionalCall(_ callback: (() -> Bool)?) -> Bool {
    if callback?() == true { return true }
    return false
  }
}

// MARK: - Вложенные вызовы остаются в условии цикла repeat
enum Examples {

  static func repeatExcluded(_ value: Int) {
    repeat {
      print(value)
    } while abs(abs(value)) > 0
  }
}

// MARK: - Короткое арифметическое выражение в условии
enum Examples {

  static func simpleArithmetic(_ value: Int, _ offset: Int, _ limit: Int) -> Bool {
    if value + offset > limit { return true }
    return false
  }
}

// MARK: - Короткие вложенные вызовы остаются в условии guard
enum Examples {

  static func guardNestedCall(_ value: Int) -> Bool {
    guard abs(abs(value)) > 0 else { return false }
    return true
  }
}

// MARK: - Короткие вложенные вызовы в условии
enum Examples {

  static func deepShortCall(_ value: Int) -> Bool {
    if abs(abs(abs(value))) > 0 { return true }
    return false
  }
}

// MARK: - Обращение по индексу в условии
enum Examples {

  static func indexing(_ values: [Int], _ index: Int) -> Bool {
    if values[index] > 0 { return true }
    return false
  }
}

// MARK: - Вложенные вызовы остаются в условии цикла while
enum Examples {

  static func whileExcluded(_ value: Int) {
    while abs(abs(value)) > 0 { return }
  }
}

// MARK: - Вложенный вызов длиной 120 символов остаётся в условии
enum Examples {

  static func nestedAtLimit(_ text: String) -> Bool {
    if text.hasPrefix("012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234".lowercased()) { return true }
    return false
  }
}
