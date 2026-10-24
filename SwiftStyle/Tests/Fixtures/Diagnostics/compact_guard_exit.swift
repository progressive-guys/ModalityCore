// MARK: - Accepted

enum Accepted {
  static func value(_ first: Bool) -> Int {
    guard first else { return 0 }

    return 1
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Bool) -> Int {
    guard first else {
      return 0
    }

    return 1
  }
}
