// MARK: - Accepted

enum Accepted {}

// MARK: - Rejected

enum Rejected {
  static func invalid() {
    if true
  }
}
