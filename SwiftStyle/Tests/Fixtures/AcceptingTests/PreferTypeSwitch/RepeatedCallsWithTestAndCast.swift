enum Examples {

  static func repeatedMixedCalls(_ make: () -> Any) -> Int {
    if make() is String { return 1 }
    if let value = make() as? Int { return value }
    return 0
  }
}
