enum Examples {

  static func interruption(_ input: Any) -> Int {
    if input is String { return 1 }

    print("step")

    if input is Int { return 2 }

    return 0
  }
}
