// MARK: - Accepted

enum Accepted {
  static func value(_ input: Int?,
    _ fallback: Int) -> Int {
    let result = input
      ?? fallback
    return result
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ input: Int?,
    _ fallback: Int) -> Int {
    let result = input ?? fallback
    return result
  }
}
