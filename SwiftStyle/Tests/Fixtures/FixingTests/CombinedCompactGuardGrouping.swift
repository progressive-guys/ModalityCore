// MARK: - Input
enum Example {
  static func value(_ input: Int) -> Int {
    let value = input

    guard value > 0 else {
      return 0
    }

    return value
  }
}

// MARK: - Output
enum Example {

  static func value(_ input: Int) -> Int {
    let value = input
    guard value > 0 else { return 0 }
    return value
  }
}
