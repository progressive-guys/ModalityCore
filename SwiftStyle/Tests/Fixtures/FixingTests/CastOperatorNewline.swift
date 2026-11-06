// MARK: - Input
enum Examples {
  static func value(_ source: Any) -> Int? {
    source
      as? Int
  }
}

// MARK: - Output
enum Examples {
  static func value(_ source: Any) -> Int? {
    source as? Int
  }
}
