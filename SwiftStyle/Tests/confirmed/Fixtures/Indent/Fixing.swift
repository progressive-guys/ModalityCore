// MARK: - Отступы инструкций и условной компиляции
func increment(_ value: Int) -> Int {
    value + 1
}

func enabled() -> Bool {
#if DEBUG
  return true
#else
  return false
#endif
}

/// Output
func increment(_ value: Int) -> Int {
  value + 1
}

func enabled() -> Bool {
  #if DEBUG
  return true
  #else
  return false
  #endif
}

// MARK: - Продолжение шаблона case с отступом в два пробела
func selected(_ value: Int) -> Bool {
  switch value {
  case 0,
    2:
    return true

  default:
    return false
  }
}

/// Output
func selected(_ value: Int) -> Bool {
  switch value {
  case 0,
       2:
    return true
  default:
    return false
  }
}
