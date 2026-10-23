// MARK: - AssociatedValues

enum AssociatedValues {
  case first(
    Int,
    String
  )
  case second
}

// MARK: - CommentMissing

enum CommentMissing {
  case first
  /// Next value.
  case second
}

// MARK: - CommentSeparated

enum CommentSeparated {
  case first

  /// Next value.
  case second
}

// MARK: - ConditionalMissing

enum ConditionalMissing {
  #if os(macOS)
  case first
  case second
  #endif
}

// MARK: - ConditionalSeparated

enum ConditionalSeparated {
  #if os(macOS)
  case first

  case second
  #endif
}

// MARK: - GapAfterComment

enum GapAfterComment {
  case first
  /// Next value.

  case second
}

// MARK: - Grouped

enum Grouped {
  case first, second
}

// MARK: - Missing

enum Missing {
  case first
  case second
}

// MARK: - OtherDeclarations

enum OtherDeclarations {
  case first
  static var value: Int { 1 }
  case second
}

// MARK: - Separated

enum Separated {
  case first

  case second
}

// MARK: - TrailingComment

enum TrailingComment {
  case first // First value.

  /* Next value. */
  case second
}
