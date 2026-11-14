// MARK: - Case EmptyBodyRemovePadding
// MARK: Input
enum Empty {

}

// MARK: Output
enum Empty {
}

// MARK: - Case SingleCaseRemovesPadding
// MARK: Input
enum Key {

  case value
}

// MARK: Output
enum Key {
  case value
}

// MARK: - Case ThreeCodeLinesRemovePadding
// MARK: Input
extension Int {

  func incremented() -> Int {
    self + 1
  }
}

// MARK: Output
extension Int {
  func incremented() -> Int {
    self + 1
  }
}
