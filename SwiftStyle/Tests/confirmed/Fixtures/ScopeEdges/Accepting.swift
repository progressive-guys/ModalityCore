// MARK: - Case ElseStaysAttached
func value(_ flag: Bool) -> Int {
  if flag {
    return 1
  } else {
    return 2
  }
}

// MARK: - Case LeadingCommentIsPreserved
func value() -> Int {
  // A comment is a significant element.
  return 1
}
