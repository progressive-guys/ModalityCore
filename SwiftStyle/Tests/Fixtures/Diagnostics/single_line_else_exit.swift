// MARK: - Accepted

enum Accepted {
  static func value(_ ready: Bool) -> Void {
    if ready { return } else {
      print("value")
    }
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ ready: Bool) -> Void {
    if ready { return } else { print("value") }
  }
}
