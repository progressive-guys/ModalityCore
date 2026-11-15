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
