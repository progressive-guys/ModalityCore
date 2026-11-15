// MARK: - Интервалы между многострочными вариантами switch
func category(_ value: Int) -> String {
  switch value {
  case 0: return "zero"
  case 1:
    return "one"

  case 2: return "very long string that does not fit in the right to case 2"
  case 3: return "three"
  case 4:
    return "four"
  default: return "other"
  }
}

func flagValue(_ flag: Bool) -> Int {
  switch flag {
  case false:
    return 0
  case true:
    return 1
  }
}

/// Output
func category(_ value: Int) -> String {
  switch value {
  case 0: return "zero"
  case 1: return "one"
    
  case 2:
    return "very long string that does not fit in case 2"
    
  case 3: return "three"
  case 4: return "four"

  default: return "other"
  }
}

func flagValue(_ flag: Bool) -> Int {
  switch flag {
  case false:
    return 0

  case true:
    return 1
  }
}
