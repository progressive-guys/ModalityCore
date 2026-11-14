// MARK: - Case DocumentedCase
func documented() {
  enum Value {
    case first

    /// The middle value.
    case second

    case third
  }
}

// MARK: - Case PropertyBetweenCases
func otherDeclarations() {
  enum Value {
    case first
    static var value: Int { 1 }
    case second
  }
}

// MARK: - Case TrailingMultilineComment
func blockComment() {
  enum Value {
    case first /* First
      value. */

    case second
  }
}
