// MARK: - Контексты отдельных проверок и приведений типов (1)
enum Examples {

  // Разные объекты в проверках, объединённых через ИЛИ
  static func alternatingObjects(_ input: Any, _ second: Any) -> Bool {
    if input is String || second is String || input is Bool { return true }
    return false
  }

  // Объявление значения прерывает серию проверок типа
  static func unconditionalCast(_ input: Any) -> Int {
    if let item = input as? String { return item.count }

    let item = input as Any
    if item is Bool { return 3 }

    return 0
  }

  // Приведение типа внутри ветки
  static func castInBody(_ input: Any, _ ready: Bool) -> String? {
    if ready { return input as? String }
    return nil
  }
}

// MARK: - Контексты отдельных проверок и приведений типов (2)
enum Examples {

  // Проверки типа у разных объектов
  static func differentReceiver(_ input: Any, _ second: Any) -> Int {
    if input is String { return 1 }
    if second is Int { return 2 }
    return 0
  }

  // Повторный вызов для получения проверяемого объекта
  static func repeatedCalls(_ make: () -> Any) -> Int {
    if make() is String { return 1 }
    if make() is Int { return 2 }
    if make() is Bool { return 3 }

    return 0
  }

  // Одиночное приведение типа
  static func singleCheck(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    return 0
  }

  // Одиночная проверка типа
  static func singleTypeTest(_ input: Any) -> Bool {
    if input is String { return true }
    return false
  }
}

// MARK: - Контексты отдельных проверок и приведений типов (3)
enum Examples {

  // Инструкция прерывает серию проверок типа
  static func interruption(_ input: Any) -> Int {
    if input is String { return 1 }

    print("step")

    if input is Int { return 2 }

    return 0
  }

  // Проверка типа внутри замыкания
  static func closurePredicate(_ values: [Any]) -> Bool {
    if values.contains(where: { $0 is Int }) { return true }
    return false
  }
}
