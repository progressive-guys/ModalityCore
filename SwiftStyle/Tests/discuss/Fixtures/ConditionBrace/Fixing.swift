// MARK: - Case MixedConditionLines
// MARK: Input
func matches(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
  if first, second,
    third { return true }
  return false
}

// MARK: Output
func matches(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
  if first,
     second,
     third
  { return true }

  return false
}
