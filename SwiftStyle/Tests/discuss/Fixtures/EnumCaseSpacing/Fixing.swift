// MARK: - Интервалы между однострочными и многострочными вариантами перечисления
enum Value {
  case first

  case second
  case third(
    Int,
    String
  )
  case fourth
}

/// Output
enum Value {

  case first
  case second
  case third(
    Int,
    String
  )

  case fourth
}
