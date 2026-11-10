// MARK: - Input
enum Examples {

  static func process(_ input: Int?) {
    guard
      let value = input
    else { return }
    // Use the checked value.
    print(value)
  }
}

// MARK: - Output
enum Examples {

  static func process(_ input: Int?) {
    guard
      let value = input
    else { return }

    // Use the checked value.
    print(value)
  }
}
