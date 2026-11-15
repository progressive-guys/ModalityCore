// MARK: - Ветка else остаётся рядом с предыдущей веткой
func value(_ flag: Bool) -> Int {
  if flag {
    return 1
  } else {
    return 2
  }
}

// MARK: - Комментарий в начале тела функции сохраняется
func value() -> Int {
  // A comment is a significant element.
  return 1
}
