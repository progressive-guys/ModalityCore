// MARK: - Одна строка кода в теле типа
enum Single {
  case only
}

// MARK: - Пустая строка сохраняется перед тремя вариантами перечисления
enum Triple {

  case first
  case second
  case third
}

// MARK: - Пустые строки сохраняются перед тремя свойствами и комментарием документации
struct Triple {

  let first: Int

  /// A label for the second value.
  let second: Int
  let third: Int
}
