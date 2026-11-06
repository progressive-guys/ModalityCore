enum Examples {

  static func update(_ value: inout Int, values: [Int]) {
    value += 1

    guard values.contains(where: { value in value > 0 }) else { return }

    print("started")
    print("ready")
  }
}
