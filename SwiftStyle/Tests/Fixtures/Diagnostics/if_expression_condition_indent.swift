// MARK: - Accepted

enum Accepted {
  static func value(_ first: Bool, _ second: Bool) -> Int {
    let result = if first,
      second
    { 1 } else { 0 }
    return result
  }

  static func nestedArguments(_ argument: Int, _ first: Bool) -> Int {
    let result = if abs(
      abs(
        argument
      )
    ) > 0,
      first
    { 1 } else { 0 }
    return result
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Bool, _ second: Bool) -> Int {
    let result = if first,
                    second
    { 1 } else { 0 }
    return result
  }
}
