// MARK: - Case MultipleStatementsStayMultiline
func nonnegative(_ value: Int) -> Int? {
  guard value >= 0 else {
    let fallback: Int? = nil
    return fallback
  }

  return value
}
