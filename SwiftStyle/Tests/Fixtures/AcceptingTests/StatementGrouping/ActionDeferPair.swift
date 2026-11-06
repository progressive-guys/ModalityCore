enum Examples {

  static func update(_ active: inout Bool) {
    active = true
    defer { active = false }

    let value = active
    print(value)
  }
}
