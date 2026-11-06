// MARK: - Input
enum Examples {
  static func compactGap(_ value: Int) -> Int {
    switch value {
    case 0: 0

    default: 1
    }
  }

  static func multilineBody(_ value: Int) -> Int {
    switch value {
    case 0:
      0
    default: 1
    }
  }

  static func beforeComment(_ value: Int) -> Int {
    switch value {
    case 0: 0
    // The fallback value.
    default: 1
    }
  }

  static func afterComment(_ value: Int) -> Int {
    switch value {
    // The first value.
    case 0: 0
    default: 1
    }
  }

  static func conditionalGap(_ value: Int) -> Int {
    switch value {
    #if os(macOS)
    case 0: 0

    case 1: 1
    #endif
    default: 2
    }
  }

  static func extraGap(_ value: Int) -> Int {
    switch value {
    case 0: 0


    // The fallback value.
    default: 1
    }
  }
}

// MARK: - Output
enum Examples {

  static func compactGap(_ value: Int) -> Int {
    switch value {
    case 0: 0
    default: 1
    }
  }

  static func multilineBody(_ value: Int) -> Int {
    switch value {
    case 0:
      0

    default: 1
    }
  }

  static func beforeComment(_ value: Int) -> Int {
    switch value {
    case 0: 0

    // The fallback value.
    default: 1
    }
  }

  static func afterComment(_ value: Int) -> Int {
    switch value {
    // The first value.
    case 0: 0

    default: 1
    }
  }

  static func conditionalGap(_ value: Int) -> Int {
    switch value {
    #if os(macOS)
    case 0: 0
    case 1: 1
    #endif
    default: 2
    }
  }

  static func extraGap(_ value: Int) -> Int {
    switch value {
    case 0: 0

    // The fallback value.
    default: 1
    }
  }
}
