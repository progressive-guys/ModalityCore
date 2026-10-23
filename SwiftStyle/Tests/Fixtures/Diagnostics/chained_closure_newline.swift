// MARK: - Accepted

enum Accepted {
  static func value(_ values: [Int]) -> [Int] {
    values.map { $0 + 1 }
      .filter { value in
        value > 0
      }
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ values: [Int]) -> [Int] {
    values.map { $0 + 1 }.filter { value in
      value > 0
    }
  }
}
