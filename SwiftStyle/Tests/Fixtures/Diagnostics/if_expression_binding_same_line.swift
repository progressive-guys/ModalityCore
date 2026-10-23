// MARK: - Accepted

enum Accepted {
  static func value(_ ready: Bool) -> Int {
    let result = if ready { 1 } else { 0 }
    return result
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ ready: Bool) -> Int {
    let
      result = if ready { 1 } else { 0 }
    return result
  }
}
