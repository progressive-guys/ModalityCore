// MARK: - Input
enum Example {
  static func value(_ ready: Bool) -> Int {
    guard ready else { return 0 }
    print(ready)
    print("ready")

    return 1
  }
}

// MARK: - Output
enum Example {

  static func value(_ ready: Bool) -> Int {
    guard ready else { return 0 }

    print(ready)
    print("ready")

    return 1
  }
}
