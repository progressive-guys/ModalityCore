// MARK: - Case RemoveClosureTailBlank
// MARK: Input
func example() {
  let action = {
    print("value")

  }
  action()
}

// MARK: Output
func example() {
  let action = {
    print("value")
  }
  action()
}

// MARK: - Case RemoveFunctionTailBlank
// MARK: Input
func value() -> Int {
  return 1

}

// MARK: Output
func value() -> Int {
  return 1
}
