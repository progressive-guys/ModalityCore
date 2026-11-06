enum Examples {

  static func update(_ state: inout (count: Int, enabled: Bool)) {
    state.count += 1

    guard state.enabled else { return }

    print("started")
    print("ready")
  }
}
