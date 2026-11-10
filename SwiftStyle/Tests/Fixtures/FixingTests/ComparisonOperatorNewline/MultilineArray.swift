// MARK: - Input
enum Example {

  static func checkValues() {
    assert(
      [1, 2].map { $0 } == [
        1,
        2
      ]
    )
  }
}

// MARK: - Output
enum Example {

  static func checkValues() {
    assert(
      [1, 2].map { $0 }
        == [
          1,
          2
        ]
    )
  }
}
