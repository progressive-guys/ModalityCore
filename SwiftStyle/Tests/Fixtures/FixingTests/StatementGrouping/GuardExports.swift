// MARK: - Input
enum Examples {

  static func process(_ input: Int?) {
    let candidate = input

    guard let value = candidate else { return }
    print(value)
    print(value + 1)
  }
}

// MARK: - Output
enum Examples {

  static func process(_ input: Int?) {
    let candidate = input
    guard let value = candidate else { return }
    print(value)
    print(value + 1)
  }
}
