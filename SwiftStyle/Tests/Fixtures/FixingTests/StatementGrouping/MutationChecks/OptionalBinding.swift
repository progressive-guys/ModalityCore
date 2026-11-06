// MARK: - Input
enum Examples {

  static func update(_ value: inout Int?, input: Int?) {
    value = input

    guard let value else { return }
    print(value)
    print("ready")
  }
}

// MARK: - Output
enum Examples {

  static func update(_ value: inout Int?, input: Int?) {
    value = input
    guard let value else { return }
    print(value)
    print("ready")
  }
}
