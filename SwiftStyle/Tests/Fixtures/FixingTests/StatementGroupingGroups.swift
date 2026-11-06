// MARK: - Input
enum Examples {
  static func missingGapBeforeChecks(_ input: Int) -> Int {
    let x = 1
    let y = input
    if input == 1 { return x + y }

    return 0
  }

  static func missingGapBeforeReturn(_ x: Int) -> Int {
    if x == 0 { return 0 }
    if x < 0 { return -1 }
    if x == 1 { return 1 }
    return x
  }

  static func blankLineAfterGroupHeader() -> Int {
    // Input values.
    let a = 1

    let b = 2
    let c = 3

    return a + b + c
  }

  static func twoBlankLinesBetweenChecks(_ x: Int) -> Int {
    if x == 1 {
      return 1
    }


    if x == 2 { return 2 }

    return x
  }

  static func missingGapBeforeMultilineCheck(_ value: Int) {
    guard value > 0 else { return }
    if value == 1 {
      return
    }
  }

  static func missingGapAfterMultilineCheck(_ value: Int) {
    if value == 1 {
      return
    }
    guard value > 0 else { return }
  }

  static func declarationsThenChecksAndReturn() -> Int {
    let a = 1
    let b = 2

    if a == b { return a }

    if b > a {
      return b
    }

    return a
  }

  static func consecutiveChecksWithoutBlankLines(_ x: Int, _ y: Int, _ z: Int, condition: Bool) -> Int {
    guard x > 0 else { return 0 }
    if x == 1 { return 1 }

    if x + y == 2 {
      return 2
    }

    if z == 3, condition { return 2 }

    return x
  }

  static func commentStartsDeclarationGroup() -> Int {
    let a = 1

    // More input values.
    let b = 2
    let c = 3

    return a + b + c
  }

  static func conditionalBranchSeparatesReturn() -> Int {
    #if os(macOS)
    let a = 1
    let b = 2
    return a + b
    #else

    return 0
    #endif
  }
}

// MARK: - Output
enum Examples {

  static func missingGapBeforeChecks(_ input: Int) -> Int {
    let x = 1
    let y = input
    if input == 1 { return x + y }

    return 0
  }

  static func missingGapBeforeReturn(_ x: Int) -> Int {
    if x == 0 { return 0 }
    if x < 0 { return -1 }
    if x == 1 { return 1 }

    return x
  }

  static func blankLineAfterGroupHeader() -> Int {
    // Input values.
    let a = 1
    let b = 2
    let c = 3
    return a + b + c
  }

  static func twoBlankLinesBetweenChecks(_ x: Int) -> Int {
    if x == 1 {
      return 1
    }

    if x == 2 { return 2 }

    return x
  }

  static func missingGapBeforeMultilineCheck(_ value: Int) {
    guard value > 0 else { return }

    if value == 1 {
      return
    }
  }

  static func missingGapAfterMultilineCheck(_ value: Int) {
    if value == 1 {
      return
    }

    guard value > 0 else { return }
  }

  static func declarationsThenChecksAndReturn() -> Int {
    let a = 1
    let b = 2
    if a == b { return a }
    if b > a {
      return b
    }
    return a
  }

  static func consecutiveChecksWithoutBlankLines(_ x: Int, _ y: Int, _ z: Int, condition: Bool) -> Int {
    guard x > 0 else { return 0 }
    if x == 1 { return 1 }

    if x + y == 2 {
      return 2
    }

    if z == 3, condition { return 2 }

    return x
  }

  static func commentStartsDeclarationGroup() -> Int {
    let a = 1

    // More input values.
    let b = 2
    let c = 3

    return a + b + c
  }

  static func conditionalBranchSeparatesReturn() -> Int {
    #if os(macOS)
    let a = 1
    let b = 2
    return a + b
    #else

    return 0
    #endif
  }
}
