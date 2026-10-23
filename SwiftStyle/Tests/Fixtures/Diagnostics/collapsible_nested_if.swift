// MARK: - After

enum After {
  static func check(_ first: Bool, _ second: Bool) {
    if first {
      if second { print("ready") }
      print("end")
    }
  }
}

// MARK: - Before

enum Before {
  static func check(_ first: Bool, _ second: Bool) {
    if first {
      print("start")
      if second { print("ready") }
    }
  }
}

// MARK: - Binding

enum Binding {
  static func check(_ value: Int?) {
    if let value {
      if value > 0 { print(value) }
    }
  }
}

// MARK: - Comments

enum Comments {
  static func check(_ first: Bool, _ second: Bool) {
    if first {
      // Check the next condition only after the first one succeeds.
      if second { print("ready") }
    }
  }
}

// MARK: - InnerElse

enum InnerElse {
  static func check(_ first: Bool, _ second: Bool) {
    if first {
      if second { print("ready") } else { print("fallback") }
    }
  }
}

// MARK: - Merged

enum Merged {
  static func check(_ first: Bool, _ second: Bool) {
    if first, second {
      print("ready")
    }
  }
}

// MARK: - MergedBinding

enum MergedBinding {
  static func check(_ value: Int?) {
    if let value, value > 0 { print(value) }
  }
}

// MARK: - Nested

enum Nested {
  static func check(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      }
    }
  }
}

// MARK: - OuterElse

enum OuterElse {
  static func check(_ first: Bool, _ second: Bool) {
    if first {
      if second { print("ready") }
    } else {
      print("fallback")
    }
  }
}

// MARK: - ThreeLevels

enum ThreeLevels {
  static func check(_ first: Bool, _ second: Bool, _ third: Bool) {
    if first {
      if second {
        if third { print("ready") }
      }
    }
  }
}
