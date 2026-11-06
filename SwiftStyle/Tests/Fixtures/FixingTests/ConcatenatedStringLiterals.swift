// MARK: - Input
enum Examples {
  static func value() -> String {
    #"first"# + #"second"#
  }
}

// MARK: - Output
enum Examples {
  static func value() -> String {
    "firstsecond"
  }
}
