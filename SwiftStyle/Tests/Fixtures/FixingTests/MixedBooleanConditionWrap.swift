// MARK: - Input
enum Examples {
  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    first && second
      || third
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    first
      && second
      || third
  }
}
