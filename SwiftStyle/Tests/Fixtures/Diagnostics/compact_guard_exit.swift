// MARK: - Accepted

enum Accepted {
  static func value(_ ready: Bool) -> Int {
    guard ready else { return 0 }

    return 1
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ ready: Bool) -> Int {
    guard ready else {
      return 0
    }

    return 1
  }
}
