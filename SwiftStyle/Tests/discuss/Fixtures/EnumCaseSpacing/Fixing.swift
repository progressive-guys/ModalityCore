// MARK: - Пустая строка между соседними вариантами перечисления удаляется
enum Value {
  case first

  case second
}

/// Output
enum Value {

  case first
  case second
}

// MARK: - После варианта с многострочными связанными значениями добавляется пустая строка
enum Value {

  case first(
    Int,
    String
  )
  case second
}

/// Output
enum Value {

  case first(
    Int,
    String
  )

  case second
}
