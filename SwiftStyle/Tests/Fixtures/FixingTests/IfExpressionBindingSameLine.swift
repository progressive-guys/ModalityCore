// MARK: - Input
enum Examples {
  static func value(_ first: Bool) -> Int {
    let
      result = if first { 1 } else { 0 }
    return result
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Bool) -> Int {
    let result = if first {
        1
      } else {
        0
      }
    return result
  }
}
