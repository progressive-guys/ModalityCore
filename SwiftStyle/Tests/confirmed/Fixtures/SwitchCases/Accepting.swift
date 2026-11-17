// MARK: - Компактные варианты switch и условная компиляция
// Условная компиляция разделяет варианты switch
func category(_ value: Int) -> String {
  switch value {
  case 0: return "zero"

  #if EXTRA_CASE
  case 1: return "one"
  #endif

  default: return "other"
  }
}

// Однострочные варианты switch остаются компактными
func flagValue(_ flag: Bool) -> Int {
  switch flag {
  case false: return 0
  case true: return 1
  }
}

// MARK: - Многострочные шаблоны и комментарии вариантов switch
// Многострочный шаблон варианта switch
func header(_ value: Int) -> Int {
  switch value {
  case 0,
    1: 0

  default: 1
  }
}

// Строчный комментарий после варианта switch
func inlineComment(_ value: Int) -> Int {
  switch value {
  case 0: 0 // First value.
  default: 1
  }
}

// Многострочный комментарий после варианта
func blockComment(_ value: Int) -> Int {
  switch value {
  case 0: 0 /* First
    value. */

  default: 1
  }
}
