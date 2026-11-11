// MARK: - Input
enum Examples {

  static func values() -> [Int] {
    Array(
      repeating: 1,
      count: 2
    )
      .reduce(
        into: []
      ) { values, value in
        values.append(value)
      }
  }
}

// MARK: - Output
enum Examples {

  static func values() -> [Int] {
    Array(
      repeating: 1,
      count: 2
    ).reduce(
        into: []
      ) { values, value in
        values.append(value)
      }
  }
}
