// MARK: - Case CaseContinuationTwoSpaces
// MARK: Input
func selected(_ value: Int) -> Bool {
  switch value {
  case 0,
       2:
    return true
  default:
    return false
  }
}

// MARK: Output
func selected(_ value: Int) -> Bool {
  switch value {
  case 0,
    2:
    return true
  default:
    return false
  }
}
