// MARK: - Условия if разделяются по строкам, скобка тела переносится отдельно
func matches(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
  if first, second,
    third { return true }
  return false
}

/// Output
func matches(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
  if first,
     second,
     third
  { return true }

  return false
}
