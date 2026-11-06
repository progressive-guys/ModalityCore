enum Examples {

  static func check(_ enabled: Bool, _ values: [Int]) {
    let first = values.first ?? 0
    print(first)

    let isReady = enabled

    if enabled {
      print(isReady, first)
    }
  }
}
