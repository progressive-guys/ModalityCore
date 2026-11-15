// MARK: - Пустая строка между короткими case внутри условной компиляции удаляется
func conditionalGap(_ value: Int) -> Int {
  switch value {
  #if os(macOS)
  case 0: 0

  case 1: 1
  #endif
  default: 2
  }
}

/// Output
func conditionalGap(_ value: Int) -> Int {
  switch value {
  #if os(macOS)
  case 0: 0
  case 1: 1
  #endif
  default: 2
  }
}

// MARK: - Вариант switch с ведущим комментарием отделяется с обеих сторон
func category(_ value: Int) -> String {
  switch value {
  case 0: return "zero"
  // A named special case.
  case 1: return "one"
  default: return "other"
  }
}

/// Output
func category(_ value: Int) -> String {
  switch value {
  case 0: return "zero"

  // A named special case.
  case 1: return "one"

  default: return "other"
  }
}
