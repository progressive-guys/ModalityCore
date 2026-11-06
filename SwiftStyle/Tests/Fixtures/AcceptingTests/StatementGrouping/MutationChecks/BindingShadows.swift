enum Examples {

  static func update(_ value: inout Int?, other: Int?) {
    value = 1

    if let value = other, value > 0 {
      print(value)
    }

    print("ready")
  }
}
