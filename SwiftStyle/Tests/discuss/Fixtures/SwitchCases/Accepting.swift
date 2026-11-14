// MARK: - Case ContinuedPattern
func header(_ value: Int) -> Int {
  switch value {
  case 0,
    1: 0

  default: 1
  }
}

// MARK: - Case TrailingLineComment
func inlineComment(_ value: Int) -> Int {
  switch value {
  case 0: 0 // First value.
  default: 1
  }
}

// MARK: - Case TrailingMultilineComment
func blockComment(_ value: Int) -> Int {
  switch value {
  case 0: 0 /* First
    value. */

  default: 1
  }
}
