// MARK: - Input
enum Examples {

  static var value: Int {

    1
  }

  static func empty() {

    // Empty body.
  }

  static func threeLines() {

    // Each call is one code line.
    print(1)
    print(2)
    print(3)
  }

  static func fourLines() {

    print(1)
    print(2)
    print(3)
    print(4)
  }

  static func nested(_ value: Int) {
    if value > 0 {

      // Keep this comment.
      print(value)
      print(value)
    }
  }

  static func closure() -> [Int] {
    [1].map { value in

      value + 1
    }
  }

  static func selection(_ value: Int) -> Int {
    switch value {

    case 0: 0
    default: 1
    }
  }
}

// MARK: - Output
enum Examples {

  static var value: Int {
    1
  }

  static func empty() {
    // Empty body.
  }

  static func threeLines() {
    // Each call is one code line.
    print(1)
    print(2)
    print(3)
  }

  static func fourLines() {
    print(1)
    print(2)
    print(3)
    print(4)
  }

  static func nested(_ value: Int) {
    if value > 0 {
      // Keep this comment.
      print(value)
      print(value)
    }
  }

  static func closure() -> [Int] {
    [1].map { value in
      value + 1
    }
  }

  static func selection(_ value: Int) -> Int {
    switch value {
    case 0: 0
    default: 1
    }
  }
}
