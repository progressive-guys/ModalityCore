// MARK: - Input
enum Examples {
  static func value(_ text: String) -> String {
    """
    Hello \(text)
    """
  }
}

// MARK: - Output
enum Examples {
  static func value(_ text: String) -> String {
    "Hello \(text)"
  }
}
