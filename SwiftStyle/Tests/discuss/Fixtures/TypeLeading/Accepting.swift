// MARK: - Case ThreeCodeLines
enum Triple {
  case first
  case second
  case third
}

// MARK: - Case ThreeCodeLinesWithDocComment
struct Triple {
  let first: Int

  /// A label for the second value.
  let second: Int
  let third: Int
}
