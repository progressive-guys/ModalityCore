// MARK: - Input
enum Examples {
  static func values() -> [Int] {
    let text = String(
      repeating: "a",
      count: 2
    )

    let count = text.count

    return Array(
      repeating: count,
      count: 2
    )
      .map { value in
        value + 1
      }
  }
}

// MARK: - Output
enum Examples {
  static func values() -> [Int] {
    let text = String(
      repeating: "a",
      count: 2
    )

    let count = text.count

    return Array(
      repeating: count,
      count: 2
    ).map { value in
        value + 1
      }
  }
}
