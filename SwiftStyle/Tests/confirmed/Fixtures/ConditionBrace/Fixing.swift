// MARK: - Открывающая скобка многострочного if на отдельной строке
func sum(_ first: Int?, _ second: Int?) -> Int {
  if let first,
     let second {
    return first + second
  }

  return 0
}

/// Output
func sum(_ first: Int?, _ second: Int?) -> Int {
  if
    let first,
    let second
  {
    return first + second
  }

  return 0
}

// MARK: - Условия if разделяются по строкам, скобка тела переносится отдельно
func matches(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
  if first, second,
    third { return true }
  return false
}

/// Output
func matches(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
  if
    first,
    second,
    third
  {
    return true
  }

  return false
}
