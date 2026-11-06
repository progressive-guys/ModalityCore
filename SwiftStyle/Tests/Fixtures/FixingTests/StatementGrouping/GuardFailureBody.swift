// MARK: - Input
enum Examples {

  static func process(_ input: Int, enabled: Bool) {
    let value = input

    guard enabled else {
      print(value)
      return
    }
    print(value)
  }
}

// MARK: - Output
enum Examples {

  static func process(_ input: Int, enabled: Bool) {
    let value = input
    guard enabled else {
      print(value)
      return
    }
    print(value)
  }
}
