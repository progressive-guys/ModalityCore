enum Examples {

  static func differentReceiver(_ input: Any, _ second: Any) -> Int {
    if input is String { return 1 }
    if second is Int { return 2 }
    return 0
  }
}
