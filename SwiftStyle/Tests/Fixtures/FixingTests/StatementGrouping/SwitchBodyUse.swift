// MARK: - Input
enum Examples {

  static func label(_ kind: Int, center: Int) {
    let angle = center + 90
    switch kind {
    case 0:
      print("label", angle)

    default:
      print("circular", angle)
    }
  }
}

// MARK: - Output
enum Examples {

  static func label(_ kind: Int, center: Int) {
    let angle = center + 90

    switch kind {
    case 0:
      print("label", angle)

    default:
      print("circular", angle)
    }
  }
}
