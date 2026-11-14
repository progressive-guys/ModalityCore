// MARK: - Case EscapedIdentifier
enum Examples {

  static func backticks(_ `default`: Int) -> Bool {
    if `default` > 0 { return true }
    return false
  }
}

// MARK: - Case LiteralAndCommentBytes
func text() -> String {
  // Keep  two spaces and punctuation: (, ).
  return #"value :  [a, b]"#
}

// MARK: - Case NestedMultilineInterpolation
let nested = """
value: \(
  """
  inner
  """
)
end
"""

// MARK: - Case RawRegexConditionText
enum Examples {
  static var regex: Regex<(Substring, Substring)> { #/if check(value)/# }
}

// MARK: - Case UnicodeIdentifierInExpression
enum Examples {

  static func unicode(_ значение: Int) -> Bool {
    if значение > 0 { return true }
    return false
  }
}

// MARK: - Case UnicodeWithoutFinalLF
let decomposed = "Café"