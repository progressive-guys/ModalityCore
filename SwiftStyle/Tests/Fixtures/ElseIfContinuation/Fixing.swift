// MARK: Input
func matches(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
  if first {
    return true
  } else if second,
            third
  {
    return true
  }

  return false
}

// MARK: Output
func matches(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
  if first {
    return true
  } else if second,
    third
  {
    return true
  }

  return false
}
