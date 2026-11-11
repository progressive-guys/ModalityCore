// MARK: - Input
enum Examples {

  static func value() -> String {
    let value = String(
      repeating: "a",
      // This comment does not add an argument code line.
      count: max(1,
        2)
    )

    return value
  }
}

// MARK: - Output
enum Examples {

  static func value() -> String {
    let value = String(
      repeating: "a",
      // This comment does not add an argument code line.
      count: max(
        1,
        2
      )
    )

    return value
  }
}
