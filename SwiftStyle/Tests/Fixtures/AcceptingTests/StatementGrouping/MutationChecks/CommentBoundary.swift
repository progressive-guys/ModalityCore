enum Examples {

  static func update(_ value: inout Int) {
    value += 1

    // Validate the result.
    guard value > 0 else { return }

    print("started")
    print("ready")
  }
}
