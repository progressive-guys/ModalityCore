// MARK: - Полное имя возвращаемого типа помещается на одной строке
enum Examples {
  struct Result {}
  static func value() -> Examples
    .Result { .init() }
}

/// Output
enum Examples {

  struct Result {}

  static func value() -> Examples.Result { .init() }
}

// MARK: - Стрелка возвращаемого типа соединяется с сигнатурой
enum Examples {
  static func value()
    -> Int { 1 }
}

/// Output
enum Examples {
  static func value() -> Int { 1 }
}

// MARK: - Кортеж возвращаемого типа помещается на одной строке
enum Examples {
  static func value() -> (
    Int, Int
  ) { (1, 2) }
}

/// Output
enum Examples {
  static func value() -> (Int, Int) { (1, 2) }
}
