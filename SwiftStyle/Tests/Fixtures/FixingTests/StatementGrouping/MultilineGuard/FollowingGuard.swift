// MARK: - Input
enum Examples {

  static func process(_ input: Int?) {
    guard
      let value = input
    else { return }
    guard value > 0 else { return }
    print(value)
  }
}

// MARK: - Output
enum Examples {

  static func process(_ input: Int?) {
    guard
      let value = input
    else { return }

    guard value > 0 else { return }
    print(value)
  }
}
