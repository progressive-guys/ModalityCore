// MARK: - Accepted

enum Accepted {
  static func value(_ source: Int?, _ defaults: (value: Int, other: Bool)) -> Int {
    source
      ?? defaults.value
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ source: Int?, _ defaults: (value: Int, other: Bool)) -> Int {
    source ??
      defaults.value
  }
}
