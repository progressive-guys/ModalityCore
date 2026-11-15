// MARK: - Условная компиляция разделяет варианты switch
func category(_ value: Int) -> String {
  switch value {
  case 0: return "zero"

  #if EXTRA_CASE
  case 1: return "one"
  #endif

  default: return "other"
  }
}

// MARK: - Однострочные варианты switch остаются компактными
func flagValue(_ flag: Bool) -> Int {
  switch flag {
  case false: return 0
  case true: return 1
  }
}
