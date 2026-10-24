// MARK: - Accepted

enum Accepted {

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

  static func differentLocalTypesSeparated() -> String {
    let k = 1

    let name = "value"

    return name + String(k)
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

  static func blankLineBeforeMultilineIf(_ x: Int) -> Int {
    if x == 1 { return 1 }

    if x == 2 {
      return 2
    }

    return x
  }

  static func blankLineAfterMultilineIf(_ x: Int) -> Int {
    if x == 1 {
      return 1
    }

    if x == 2 { return 2 }

    return x
  }
}

// MARK: - Rejected

enum Rejected {

  static func blankLineBetweenLocalDeclarations() -> Int {
    let a = 1

    let b = 2

    return a + b
  }

  static func missingGapBeforeChecks() -> Int {
    let x = 1
    if x == 1 { return x }

    return 0
  }

  static func missingGapBeforeReturn(_ x: Int) -> Int {
    if x == 1 { return 1 }
    return x
  }

  static func missingGapBetweenLocalTypes() -> String {
    let k = 1
    let name = "value"

    return name + String(k)
  }

  static func blankLineAfterGroupHeader() -> Int {
    // Input values.
    let a = 1

    let b = 2

    return a + b
  }

  static func twoBlankLinesBeforeReturn() -> Int {
    let x = 1


    return x
  }

  static func blankLineBetweenCompactChecks(_ x: Int) -> Int {
    if x == 1 { return 1 }

    if x == 2 { return 2 }

    return x
  }

  static func twoBlankLinesBetweenChecks(_ x: Int) -> Int {
    if x == 1 {
      return 1
    }


    if x == 2 { return 2 }

    return x
  }
}
