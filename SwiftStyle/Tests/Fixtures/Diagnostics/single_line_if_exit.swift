// MARK: - Accepted

enum Accepted {
  static func value(_ ready: Bool) -> Void {
    if ready {
      print("value")
    }
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ ready: Bool) -> Void {
    if ready { print("value") }
  }
}
