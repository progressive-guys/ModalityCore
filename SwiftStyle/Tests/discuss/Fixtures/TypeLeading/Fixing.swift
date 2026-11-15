// MARK: - Удаление пустых строк из пустого тела типа
enum Empty {

}

/// Output
enum Empty {
}

// MARK: - Удаление пустой строки перед единственным вариантом перечисления
enum Key {

  case value
}

/// Output
enum Key {
  case value
}

// MARK: - Вход и выход совпадают: пустая строка в начале расширения сохраняется
extension Int {

  func incremented() -> Int {
    self + 1
  }
}

/// Output
extension Int {

  func incremented() -> Int {
    self + 1
  }
}
