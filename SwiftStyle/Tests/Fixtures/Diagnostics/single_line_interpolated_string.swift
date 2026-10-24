// MARK: - Accepted

enum Accepted {
  static func value(_ text: String) -> String {
    "Hello \(text)"
  }

  static func explicitNewline(_ text: String) -> String {
    """
    Hello \(text)\n
    """
  }

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
