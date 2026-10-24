// MARK: - Accepted

enum Accepted {
  static func value(_ text: String) -> String {
    "Hello \(text)"
  }
}

// MARK: - ExplicitNewline

enum ExplicitNewline {
  static func value(_ text: String) -> String {
    """
    Hello \(text)\n
    """
  }
}

// MARK: - RawLiteral

enum RawLiteral {
  static let raw = #"""
    Hello \(text)
    """#
}

// MARK: - Rejected

enum Rejected {
  static func value(_ text: String) -> String {
    """
    Hello \(text)
    """
  }
}
