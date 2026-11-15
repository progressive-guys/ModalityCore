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
