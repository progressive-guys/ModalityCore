// MARK: - Input
enum Examples {
  static func value(_ values: [Int]) -> [Int] {
    values.map { $0 + 1 }.filter { value in
      value > 0
    }
  }
}

// MARK: - Output
enum Examples {

  static func value(_ values: [Int]) -> [Int] {
    values.map { $0 + 1 }
      .filter { value in
      value > 0
    }
  }
}
