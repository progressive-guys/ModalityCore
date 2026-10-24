// MARK: - Accepted

enum Accepted {
  static func value(_ first: Int, _ second: Int) -> Int {
    first
      + second
  }


  static func conversion(_ first: Int, _ second: Int) -> Double {
    Double(first - second) / 12
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ first: Int, _ second: Int) -> Int {
    first
      +
      second
  }

  static func trailing(_ first: Int, _ second: Int) -> Int {
    first +
      second
  }
}
