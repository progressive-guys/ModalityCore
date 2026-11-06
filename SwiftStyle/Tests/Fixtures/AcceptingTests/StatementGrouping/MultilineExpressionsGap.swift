enum Examples {

  static func process(_ input: Int) -> Int {
    let value = max(
      input,
      0
    )

    print(
      value,
      value + 1
    )
    return value
  }
}
