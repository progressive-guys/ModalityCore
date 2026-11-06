// MARK: - Input
enum Examples {

  static func check(_ enabled: Bool, _ values: [Int]) {
    let first = values.first ?? 0
    let last = values.last ?? 0
    print(first, last)

    let isReady = enabled

    if isReady, first < last {
      print(first, last)
    }
  }

  static func guardCheck(_ enabled: Bool, _ values: [Int]) {
    let first = values.first ?? 0
    let last = values.last ?? 0
    print(first, last)

    let isReady = enabled

    guard isReady, first < last else { return }
    print(first, last)
  }
}

// MARK: - Output
enum Examples {

  static func check(_ enabled: Bool, _ values: [Int]) {
    let first = values.first ?? 0
    let last = values.last ?? 0
    print(first, last)

    let isReady = enabled
    if isReady, first < last {
      print(first, last)
    }
  }

  static func guardCheck(_ enabled: Bool, _ values: [Int]) {
    let first = values.first ?? 0
    let last = values.last ?? 0
    print(first, last)

    let isReady = enabled
    guard isReady, first < last else { return }
    print(first, last)
  }
}
