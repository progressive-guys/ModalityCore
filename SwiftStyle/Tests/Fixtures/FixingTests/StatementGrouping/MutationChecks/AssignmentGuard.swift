// MARK: - Input
enum Examples {

  static func update(_ state: inout (count: Int, enabled: Bool), value: Int) {
    state.count = value

    guard state.count > 0 else { return }

    print("started")
    print("ready")
  }
}

// MARK: - Output
enum Examples {

  static func update(_ state: inout (count: Int, enabled: Bool), value: Int) {
    state.count = value
    guard state.count > 0 else { return }

    print("started")
    print("ready")
  }
}
