// MARK: - Input
enum Examples {
  struct Result {}
  static func value() -> Examples
    .Result { .init() }
}

// MARK: - Output
enum Examples {
  struct Result {}

  static func value() -> Examples.Result { .init() }
}
