// MARK: - Input
enum Examples {
  static func value(_ first: Bool, _ second: Bool) -> Int {
    let result = if first,
                    second
    { 1 } else { 0 }
    return result
  }
}

// MARK: - Output
enum Examples {

  static func value(_ first: Bool, _ second: Bool) -> Int {
    let result = if first,
      second
    {
      1
    } else {
      0
    }
    return result
  }
}
