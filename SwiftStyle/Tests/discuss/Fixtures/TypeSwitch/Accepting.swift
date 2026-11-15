// MARK: - Разные объекты в проверках, объединённых через ИЛИ
enum Examples {

  static func alternatingObjects(_ input: Any, _ second: Any) -> Bool {
    if input is String || second is String || input is Bool { return true }
    return false
  }
}

// MARK: - Объявление значения прерывает серию проверок типа
enum Examples {

  static func unconditionalCast(_ input: Any) -> Int {
    if let item = input as? String { return item.count }

    let item = input as Any
    if item is Bool { return 3 }

    return 0
  }
}

// MARK: - Приведение типа внутри ветки
enum Examples {

  static func castInBody(_ input: Any, _ ready: Bool) -> String? {
    if ready { return input as? String }
    return nil
  }
}

// MARK: - Проверки типа у разных объектов
enum Examples {

  static func differentReceiver(_ input: Any, _ second: Any) -> Int {
    if input is String { return 1 }
    if second is Int { return 2 }
    return 0
  }
}

// MARK: - Повторный вызов для получения проверяемого объекта
enum Examples {

  static func repeatedCalls(_ make: () -> Any) -> Int {
    if make() is String { return 1 }
    if make() is Int { return 2 }
    if make() is Bool { return 3 }

    return 0
  }
}

// MARK: - Одиночное приведение типа
enum Examples {

  static func singleCheck(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    return 0
  }
}

// MARK: - Одиночная проверка типа
enum Examples {

  static func singleTypeTest(_ input: Any) -> Bool {
    if input is String { return true }
    return false
  }
}

// MARK: - Инструкция прерывает серию проверок типа
enum Examples {

  static func interruption(_ input: Any) -> Int {
    if input is String { return 1 }

    print("step")

    if input is Int { return 2 }

    return 0
  }
}

// MARK: - Проверка типа внутри замыкания
enum Examples {

  static func closurePredicate(_ values: [Any]) -> Bool {
    if values.contains(where: { $0 is Int }) { return true }
    return false
  }
}
