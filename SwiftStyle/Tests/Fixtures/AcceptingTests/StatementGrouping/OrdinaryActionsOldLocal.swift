enum Examples {

  static func update(_ input: Int, active: inout Bool, offset: inout Int, notify: (Int) -> Void) {
    let topOffset = input

    guard input > 0 else { return }

    active = true
    offset = topOffset
    notify(offset)
  }
}
