// MARK: - Input
enum Examples {

  static func update(_ value: inout Int, values: [Int]) {
    value += 1

    guard values.contains(where: { $0 == value }) else { return }

    print("started")
    print("ready")
  }
}

// MARK: - Output
enum Examples {

  static func update(_ value: inout Int, values: [Int]) {
    value += 1
    guard values.contains(where: { $0 == value }) else { return }

    print("started")
    print("ready")
  }
}
