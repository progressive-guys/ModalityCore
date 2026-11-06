enum Examples {

  static func repeatedCalls(_ make: () -> Any) -> Int {
    if make() is String { return 1 }
    if make() is Int { return 2 }
    if make() is Bool { return 3 }

    return 0
  }
}
