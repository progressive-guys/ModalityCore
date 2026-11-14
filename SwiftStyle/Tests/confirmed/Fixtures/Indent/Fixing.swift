// MARK: - Case BodyFourToTwoSpaces
// MARK: Input
func increment(_ value: Int) -> Int {
    value + 1
}

// MARK: Output
func increment(_ value: Int) -> Int {
  value + 1
}

// MARK: - Case ConditionalDirectiveUsesScope
// MARK: Input
func enabled() -> Bool {
#if DEBUG
  return true
#else
  return false
#endif
}

// MARK: Output
func enabled() -> Bool {
  #if DEBUG
  return true
  #else
  return false
  #endif
}
