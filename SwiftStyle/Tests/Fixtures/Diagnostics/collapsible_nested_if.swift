// MARK: - Accepted

enum Accepted {
  static func after(_ first: Bool, _ second: Bool) {
    if first {
      if second { print("ready") }
      print("end")
    }
  }

  static func before(_ first: Bool, _ second: Bool) {
    if first {
      print("start")
      if second { print("ready") }
    }
  }

  static func innerElse(_ first: Bool, _ second: Bool) {
    if first {
      if second { print("ready") } else { print("fallback") }
    }
  }

  static func merged(_ first: Bool, _ second: Bool) {
    if first, second {
      print("ready")
    }
  }

  static func mergedBinding(_ value: Int?) {
    if let value, value > 0 { print(value) }
  }

  static func outerElse(_ first: Bool, _ second: Bool) {
    if first {
      if second { print("ready") }
    } else {
      print("fallback")
    }
  }
}

// MARK: - Rejected

enum Rejected {
  static func binding(_ value: Int?) {
    if let value {
      if value > 0 { print(value) }
    }
  }

  static func comments(_ first: Bool, _ second: Bool) {
    if first {
      // Check the next condition only after the first one succeeds.
      if second { print("ready") }
    }
  }

  static func nested(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      }
    }
  }

  static func threeLevels(_ first: Bool, _ second: Bool, _ third: Bool) {
    if first {
      if second {
        if third { print("ready") }
      }
    }
  }
}
