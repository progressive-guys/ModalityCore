// MARK: - Accepted

enum Accepted {
  static func value(_ input: (width: Int, height: Int)) -> Int {
    input.width + input.height
  }
}

// MARK: - Rejected

enum Rejected {
  static func value(_ input: (width: Int, height: Int)) -> Int {
    input
      .width + input.height
  }
}
