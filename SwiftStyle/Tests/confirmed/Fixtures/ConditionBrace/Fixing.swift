// MARK: - Case MultilineIfBraceOnOwnLine
// MARK: Input
func sum(_ first: Int?, _ second: Int?) -> Int {
  if let first,
     let second {
    return first + second
  }

  return 0
}

// MARK: Output
func sum(_ first: Int?, _ second: Int?) -> Int {
  if let first,
    let second
  {
    return first + second
  }

  return 0
}
