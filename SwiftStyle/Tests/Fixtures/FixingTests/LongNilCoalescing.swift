// MARK: - Input
enum Examples {
  static func value(_ input: Int?,
    _ fallback: Int) -> Int {
    let result = input.flatMap { $0.isMultiple(of: 2) ? $0 : nil } ?? (fallback.isMultiple(of: 2) ? fallback : fallback + 1)
    return result
  }
}

// MARK: - Output
enum Examples {

  static func value(_ input: Int?,
    _ fallback: Int) -> Int {
    let result = input.flatMap { $0.isMultiple(of: 2) ? $0 : nil }
      ?? (fallback.isMultiple(of: 2) ? fallback : fallback + 1)
    return result
  }
}
