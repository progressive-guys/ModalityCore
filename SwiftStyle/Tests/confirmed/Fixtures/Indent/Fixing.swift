// MARK: - Отступ выражения в теле функции уменьшается с четырёх до двух пробелов
func increment(_ value: Int) -> Int {
    value + 1
}

/// Output
func increment(_ value: Int) -> Int {
  value + 1
}

// MARK: - Директива условной компиляции следует отступу блока
func enabled() -> Bool {
#if DEBUG
  return true
#else
  return false
#endif
}

/// Output
func enabled() -> Bool {
  #if DEBUG
  return true
  #else
  return false
  #endif
}
