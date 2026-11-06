enum Examples {

  static func update(_ value: inout Int, enabled: Bool) {
    value += 1

    if enabled {
      print(value)
    }

    print("ready")
  }
}
