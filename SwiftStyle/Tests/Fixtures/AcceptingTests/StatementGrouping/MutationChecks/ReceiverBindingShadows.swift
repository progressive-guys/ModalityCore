enum Examples {

  static func update(_ state: inout (count: Int, enabled: Bool), other: (count: Int, enabled: Bool)?) {
    state.count += 1

    if let state = other, state.count > 0 {
      print(state.count)
    }

    print("ready")
  }
}
