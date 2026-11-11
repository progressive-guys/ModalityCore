enum Examples {

  static func values() -> [Int] {
    Array(
      repeating: 1,
      count: 2
    )
      // Keep this comment with the transformation.
      .map { value in
        value + 1
      }
  }
}
