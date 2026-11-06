enum Examples {

  static func update(_ value: inout Int) {
    value += 1
    print("tick")

    guard value > 0 else { return }

    print("ready")
  }
}
