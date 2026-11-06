enum Examples {

  static func update(_ left: inout (count: Int, enabled: Bool), right: (count: Int, enabled: Bool)) {
    left.count += 1

    guard right.count > 0 else { return }

    print("started")
    print("ready")
  }
}
