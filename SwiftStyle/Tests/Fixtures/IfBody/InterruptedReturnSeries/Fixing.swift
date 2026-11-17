// MARK: Input
func category(_ first: Bool, _ second: Bool, between: () -> Void) -> Int {
  if first { return 1 }
  between()
  if second { return 2 }
  return 0
}

// MARK: Output
func category(_ first: Bool, _ second: Bool, between: () -> Void) -> Int {
  if first {
    return 1
  }

  between()

  if second {
    return 2
  }

  return 0
}
