enum Examples {

  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted()
      .contains(
        value
      )
  }
}
