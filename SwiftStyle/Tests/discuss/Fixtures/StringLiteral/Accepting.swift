// MARK: - Case EmptyContentLineWithoutMarginSpaces
enum Examples {

  static func blankLinesAndIndentation() -> String {
    """
    first
      second

    last
    """
  }
}

// MARK: - Case ExplicitNewlinePreventsSingleLineRewrite
enum Examples {

  static func explicitNewline(_ text: String) -> String {
    """
    Hello \(text)\n
    """
  }
}

// MARK: - Case LiteralAfterExplicitReturn
enum Examples {

  static func inlineReturn() -> String {
    return """
      first
      second
      """
  }
}

// MARK: - Case RawLiteralInterpolationLikeText
enum Examples {

  static let raw = #"""
    Hello \(text)
    """#
}

// MARK: - Case SemicolonInsideLiteral
enum Examples {

  static func status(_ failure: String?) -> String {
    var value = "a; return"
    if let failure {
      value = "Error: \(failure)"
      return value
    }
    return value
  }
}
