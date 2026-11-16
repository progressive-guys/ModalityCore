// MARK: - Тело перечисления переносится, варианты остаются на одной строке
enum Choice { case first, second }

/// Output
enum Choice {
  case first, second
}

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
