// MARK: - Интервалы вариантов switch при комментариях и условной компиляции
func conditionalGap(_ value: Int) -> Int {
  switch value {
  #if os(macOS)
  case 0: 0

  case 1: 1
  #endif
  default: 2
  }
}

func category(_ value: Int) -> String {
  switch value {
  case 0: return "zero"
  // A named special case.
  case 1: return "one"
  default: return "other"
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

func category(_ value: Int) -> String {
  switch value {
  case 0: return "zero"

  // A named special case.
  case 1: return "one"

  default: return "other"
  }
}
