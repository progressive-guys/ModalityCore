// MARK: - Accepted

enum Accepted {
  struct Result {}
  static func value() -> Accepted.Result { .init() }
}

// MARK: - Rejected

enum Rejected {
  struct Result {}
  static func value() -> Rejected
    .Result { .init() }
}
