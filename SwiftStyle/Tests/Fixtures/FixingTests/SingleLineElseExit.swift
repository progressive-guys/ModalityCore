// MARK: - Input
enum Examples {
  static func value(_ first: Bool) -> Void {
    if first { return } else { print("value") }
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Bool) -> Void {
    if first { return } else {
      print("value")
    }
  }
}
