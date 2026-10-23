// MARK: - Accepted

enum Accepted {
  static func value(_ ready: Bool, _ available: Bool) -> Int {
    let result = if ready,
      available
    { 1 } else { 0 }
    return result
  }
}

// MARK: - NestedArguments

enum NestedArguments {
  static func value(_ argument: Int, _ ready: Bool) -> Int {
    let result = if abs(
      abs(
        argument
      )
    ) > 0,
      ready
    { 1 } else { 0 }
    return result
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ ready: Bool, _ available: Bool) -> Int {
    let result = if ready,
                    available
    { 1 } else { 0 }
    return result
  }
}
