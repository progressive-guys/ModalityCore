// MARK: - Перед четырьмя вариантами перечисления добавляется пустая строка
enum Quartet {
  case first
  case second
  case third
  case fourth
}

/// Output
enum Quartet {

  case first
  case second
  case third
  case fourth
}

// MARK: - Пустой сценарий без входа и ожидаемого результата

// MARK: - Разворачивание тела перечисления: имена типов во входе и выходе различаются
enum Single { case only }


/// Output
enum Quartet {
  case only
}

// MARK: - Пустое перечисление сокращается до одной строки
enum Single {
}


/// Output
enum Single { }

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
