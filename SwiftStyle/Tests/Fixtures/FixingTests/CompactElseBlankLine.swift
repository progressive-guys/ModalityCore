// MARK: - Input
enum Examples {
  static func value(_ first: Bool) -> Int {
    guard first else { return 0 }
    print(first)
    print("ready")

    return 1
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Bool) -> Int {
    guard first else { return 0 }

    print(first)
    print("ready")

    return 1
  }
}
