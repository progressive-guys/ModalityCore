// MARK: - Input
enum Examples {
  static func select(_ value: Int) -> Int {
    switch value {
    case 1,
         2: 1
    default: 0
    }
  }
}

// MARK: - Output
enum Examples {

  static func select(_ value: Int) -> Int {
    switch value {
    case 1,
      2: 1

    default: 0
    }
  }
}
