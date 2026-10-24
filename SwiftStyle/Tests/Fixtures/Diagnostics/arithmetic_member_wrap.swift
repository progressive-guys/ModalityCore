// MARK: - Accepted

enum Accepted {
  static func value(_ input: (first: Int, second: Int)) -> Int {
    input.first + input.second
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ input: (first: Int, second: Int)) -> Int {
    input
      .first + input.second
  }
}
