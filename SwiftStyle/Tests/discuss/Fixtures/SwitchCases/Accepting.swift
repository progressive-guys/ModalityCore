// MARK: - Многострочный шаблон варианта switch
func header(_ value: Int) -> Int {
  switch value {
  case 0,
    1: 0

  default: 1
  }
}

// MARK: - Строчный комментарий после варианта switch
func inlineComment(_ value: Int) -> Int {
  switch value {
  case 0: 0 // First value.
  default: 1
  }
}

// MARK: - Многострочный комментарий после варианта
func blockComment(_ value: Int) -> Int {
  switch value {
  case 0: 0 /* First
    value. */

  default: 1
  }
}
