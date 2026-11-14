// MARK: - Case ConditionalGroupAtStart
// MARK: Input
func conditionalGap(_ value: Int) -> Int {
  switch value {
  #if os(macOS)
  case 0: 0

  case 1: 1
  #endif
  default: 2
  }
}

// MARK: Output
func conditionalGap(_ value: Int) -> Int {
  switch value {
  #if os(macOS)
  case 0: 0
  case 1: 1
  #endif
  default: 2
  }
}

// MARK: - Case LeadingCommentBelongsToCase
// MARK: Input
func category(_ value: Int) -> String {
  switch value {
  case 0: return "zero"
  // A named special case.
  case 1: return "one"
  default: return "other"
  }
}

// MARK: Output
func category(_ value: Int) -> String {
  switch value {
  case 0: return "zero"

  // A named special case.
  case 1: return "one"

  default: return "other"
  }
}
