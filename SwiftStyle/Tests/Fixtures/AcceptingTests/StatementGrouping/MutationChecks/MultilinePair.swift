enum Examples {

  static func update(_ value: inout Int, input: Int) {
    value = max(
      input,
      0
    )

    if value > 0 {
      print(value)
    }
  }
}
