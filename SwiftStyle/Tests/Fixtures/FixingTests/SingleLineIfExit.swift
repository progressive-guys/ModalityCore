// MARK: - Input
enum Examples {
  static func value(_ first: Bool) -> Void {
    if first { print("value") }
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Bool) -> Void {
    if first {
      print("value")
    }
  }
}
