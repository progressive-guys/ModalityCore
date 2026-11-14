// MARK: - Case BinaryOperatorStartsContinuation
// MARK: Input
func both(_ first: Bool, _ second: Bool) -> Bool {
  first &&
  second
}

// MARK: Output
func both(_ first: Bool, _ second: Bool) -> Bool {
  first
    && second
}

// MARK: - Case TernaryOperatorsStartBranches
// MARK: Input
func choose(_ flag: Bool, first: Int, second: Int) -> Int {
  flag ?
    first :
    second
}

// MARK: Output
func choose(_ flag: Bool, first: Int, second: Int) -> Int {
  flag
    ? first
    : second
}
