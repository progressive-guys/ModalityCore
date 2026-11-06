enum Examples {}

extension Examples {

  static func consecutiveChecks(_ first: Bool, _ second: Bool) -> Int {
    guard first else { return 0 }
    if second { return 1 }
    return 2
  }
}
