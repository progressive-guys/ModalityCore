// MARK: - Input
enum Examples {

  static func update(_ value: inout Int) {
    value *= 2

    guard value > 0 else { return }

    print("started")
    print("ready")
  }
}

// MARK: - Output
enum Examples {

  static func update(_ value: inout Int) {
    value *= 2
    guard value > 0 else { return }

    print("started")
    print("ready")
  }
}
