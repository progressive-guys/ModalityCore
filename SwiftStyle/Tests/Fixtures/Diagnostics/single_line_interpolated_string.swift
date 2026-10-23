// MARK: - Accepted

enum Accepted {
  static func value(_ name: String) -> String {
    "Hello \(name)"
  }
}

// MARK: - ExplicitNewline

enum ExplicitNewline {
  static func value(_ name: String) -> String {
    """
    Hello \(name)\n
    """
  }
}

// MARK: - RawLiteral

enum RawLiteral {
  static let raw = #"""
    Hello \(name)
    """#
}

// MARK: - Rejected

enum Rejected {
  static func value(_ name: String) -> String {
    """
    Hello \(name)
    """
  }
}
