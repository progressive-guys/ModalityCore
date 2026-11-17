// MARK: - Обычное действие переносится в многострочное тело
func accumulate(_ value: Int) -> Int {
  var result = 0
  if value > 0 { result += value }

  return result
}

/// Output
func accumulate(_ value: Int) -> Int {
  var result = 0
  if value > 0 {
    result += value
  }

  return result
}
