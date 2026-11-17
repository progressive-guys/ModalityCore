// MARK: Input
func consume(_ next: () -> Int?, enabled: Bool) {
  while let value = next(),
        value > 0,
        enabled
  {
    print(value)
  }
}

// MARK: Output
func consume(_ next: () -> Int?, enabled: Bool) {
  while let value = next(),
    value > 0,
    enabled
  {
    print(value)
  }
}
