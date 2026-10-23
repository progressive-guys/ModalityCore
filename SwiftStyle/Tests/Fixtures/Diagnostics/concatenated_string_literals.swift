// MARK: - Accepted

enum Accepted {
  static func value() -> String {
    "firstsecond"
  }
}

// MARK: - Rejected

enum Rejected {
  static func value() -> String {
    #"first"# + #"second"#
  }
}
