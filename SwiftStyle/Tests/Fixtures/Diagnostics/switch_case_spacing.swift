// MARK: - Accepted

enum Accepted {
  static func compact(_ value: Int) -> Int {
    switch value {
    case 0: 0
    case 1: 1
    default: 2
    }
  }

  static func mixed(_ value: Int) -> Int {
    switch value {
    case 0:
      0

    case 1: 1
    default: 2
    }
  }

  static func documented(_ value: Int) -> Int {
    switch value {
    case 0: 0

    // The middle value.
    case 1: 1

    default: 2
    }
  }

  static func inlineComment(_ value: Int) -> Int {
    switch value {
    case 0: 0 // First value.
    default: 1
    }
  }

  static func blockComment(_ value: Int) -> Int {
    switch value {
    case 0: 0 /* First
      value. */

    default: 1
    }
  }

  static func conditional(_ value: Int) -> Int {
    switch value {
    #if os(macOS)
    case 0: 0
    case 1: 1
    #endif
    default: 2
    }
  }

  static func header(_ value: Int) -> Int {
    switch value {
    case 0,
      1: 0

    default: 1
    }
  }
}

// MARK: - Rejected

enum Rejected {
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
