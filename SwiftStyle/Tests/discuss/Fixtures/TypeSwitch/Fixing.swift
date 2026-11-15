// MARK: - Проверки превращаются в отдельные switch; дополнительное условие становится where
enum Example {

  static func extraCondition(_ input: Any, _ condition: Bool) -> Int {
    if input is String { return 1 }
    if let item = input as? [Int], condition { return item.count }
    return 0
  }
}

/// Output
enum Example {

  static func extraCondition(_ input: Any, _ condition: Bool) -> Int {
    switch (input) {
    case is String:
      return 1

    default:
      break
    }

    switch (input) {
    case let item as [Int] where (condition):
      return item.count

    default:
      break
    }

    return 0
  }
}

// MARK: - Приведение типа и проверка is превращаются в отдельные switch
enum Example {

  static func twoChecks(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    if input is Int { return 2 }
    return 0
  }
}

/// Output
enum Example {

  static func twoChecks(_ input: Any) -> Int {
    switch (input) {
    case let item as String:
      return item.count

    default:
      break
    }

    switch (input) {
    case is Int:
      return 2

    default:
      break
    }

    return 0
  }
}

// MARK: - Каждая проверка типа в выражении ИЛИ заменяется вызовом замыкания со switch
enum Example {

  static func conditionChecks(_ input: Any) -> Int {
    if input is String || input is Int { return 1 }
    return 0
  }
}

/// Output
enum Example {

  static func conditionChecks(_ input: Any) -> Int {
    if ({ () -> Bool in
      switch (input) {
      case is String: return true
      default: return false
      }
    }()) || ({ () -> Bool in
      switch (input) {
      case is Int: return true
      default: return false
      }
    }()) { return 1 }

    return 0
  }
}

// MARK: - Повторные проверки одного типа сохраняются в отдельных switch
enum Example {

  static func duplicateType(_ input: Any) -> Int {
    if input is String { return 1 }
    if input is String { return 2 }
    return 0
  }
}

/// Output
enum Example {

  static func duplicateType(_ input: Any) -> Int {
    switch (input) {
    case is String:
      return 1

    default:
      break
    }

    switch (input) {
    case is String:
      return 2

    default:
      break
    }

    return 0
  }
}

// MARK: - Ветка else последней проверки становится default последнего switch
enum Example {

  static func withElse(_ input: Any) -> Int {
    if input is String { return 1 }
    if input is Int { return 2 } else { return 0 }
  }
}

/// Output
enum Example {

  static func withElse(_ input: Any) -> Int {
    switch (input) {
    case is String:
      return 1

    default:
      break
    }

    switch (input) {
    case is Int:
      return 2

    default:
      return 0
    }
  }
}

// MARK: - Else if сохраняется внутри default при замене внешнего if на switch
enum Example {

  static func elseIfChecks(_ input: Any) -> Int {
    if input is String {
      return 1
    } else if input is Int {
      return 2
    }
    return 0
  }
}

/// Output
enum Example {

  static func elseIfChecks(_ input: Any) -> Int {
    switch (input) {
    case is String:
      return 1

    default:
      if input is Int { return 2 }
    }

    return 0
  }
}

// MARK: - Отдельные switch сохраняют приведения к классу и типу any Named
enum Example {

  protocol Named {
    var name: String { get }
  }

  class Animal { }

  final class Bird: Animal, Named {
    let name = "bird"
  }

  final class Fish: Animal { }

  static func mixedChecks(_ input: Any) -> Int {
    if let item = input as? Bird { return item.name.count }
    if input is Fish { return 2 }
    if let item = input as? any Named { return item.name.count }
    return 0
  }
}

/// Output
enum Example {

  protocol Named {
    var name: String { get }
  }

  class Animal { }

  final class Bird: Animal, Named {
    let name = "bird"
  }

  final class Fish: Animal { }

  static func mixedChecks(_ input: Any) -> Int {
    switch (input) {
    case let item as Bird:
      return item.name.count

    default:
      break
    }

    switch (input) {
    case is Fish:
      return 2

    default:
      break
    }

    switch (input) {
    case let item as any Named:
      return item.name.count

    default:
      break
    }

    return 0
  }
}

// MARK: - Приведения к обобщённым коллекциям заменяются отдельными switch
enum Example {

  static func genericTypes(_ input: Any) -> Int {
    if let item = input as? [Swift.String] { return item.count }
    if let item = input as? Dictionary<String, Int> { return item.count }
    if let item = input as? Set<Int> { return item.count }
    return 0
  }
}

/// Output
enum Example {

  static func genericTypes(_ input: Any) -> Int {
    switch (input) {
    case let item as [Swift.String]:
      return item.count

    default:
      break
    }

    switch (input) {
    case let item as Dictionary<String, Int>:
      return item.count

    default:
      break
    }

    switch (input) {
    case let item as Set<Int>:
      return item.count

    default:
      break
    }

    return 0
  }
}

// MARK: - Привязка var сохраняется в case при замене проверки на switch
enum Example {

  static func mutableBinding(_ input: Any) -> Int {
    if var item = input as? String {
      item.append("suffix")
      return item.count
    }
    if input is Int { return 2 }
    return 0
  }
}

/// Output
enum Example {

  static func mutableBinding(_ input: Any) -> Int {
    switch (input) {
    case var item as String:
      item.append("suffix")
      return item.count

    default:
      break
    }

    switch (input) {
    case is Int:
      return 2

    default:
      break
    }

    return 0
  }
}

// MARK: - Отрицательная проверка типа переносит действие в default отдельного switch
enum Example {

  static func negatedCheck(_ input: Any) -> Int {
    if input is String { return 1 }
    if !(input is Bool) { return 3 }
    return 0
  }
}

/// Output
enum Example {

  static func negatedCheck(_ input: Any) -> Int {
    switch (input) {
    case is String:
      return 1

    default:
      break
    }

    switch (input) {
    case is Bool:
      break

    default:
      return 3
    }

    return 0
  }
}

// MARK: - Отдельные switch сохраняют оба вызова при совпадении пересекающихся типов
protocol Named { }

struct NamedValue: Named { }

func inspect(_ input: Any, record: (Int) -> Void) {
  if input is NamedValue { record(1) }
  if input is any Named { record(2) }
}

/// Output
protocol Named { }

struct NamedValue: Named { }

func inspect(_ input: Any, record: (Int) -> Void) {
  switch input {
  case is NamedValue:
    record(1)

  default:
    break
  }

  switch input {
  case is any Named:
    record(2)

  default:
    break
  }
}

// MARK: - Отдельные switch сохраняют повторное чтение вычисляемого свойства
enum Example {

  struct Box {
    var read: () -> Any
    var value: Any { read() }
  }

  static func repeatedProperties(_ input: Box) -> Int {
    if input.value is String { return 1 }
    if input.value is Int { return 2 }
    if input.value is Bool { return 3 }
    return 0
  }
}

/// Output
enum Example {

  struct Box {

    var read: () -> Any

    var value: Any {
      read()
    }
  }

  static func repeatedProperties(_ input: Box) -> Int {
    switch (input.value) {
    case is String:
      return 1

    default:
      break
    }

    switch (input.value) {
    case is Int:
      return 2

    default:
      break
    }

    switch (input.value) {
    case is Bool:
      return 3

    default:
      break
    }

    return 0
  }
}

// MARK: - Проверки типа превращаются в отдельные switch с throw в ветках
enum Example {

  enum Failure: Error {
    case unsupported
  }

  static func throwsFromEachBranch(_ input: Any) throws -> Int {
    if input is String { throw Failure.unsupported }
    if input is Int { throw Failure.unsupported }
    return 0
  }
}

/// Output
enum Example {

  enum Failure: Error {
    case unsupported
  }

  static func throwsFromEachBranch(_ input: Any) throws -> Int {
    switch (input) {
    case is String:
      throw Failure.unsupported

    default:
      break
    }

    switch (input) {
    case is Int:
      throw Failure.unsupported

    default:
      break
    }

    return 0
  }
}
