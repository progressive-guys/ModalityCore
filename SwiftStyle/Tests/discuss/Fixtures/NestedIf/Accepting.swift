// MARK: - Case InnerElseBranch
enum Examples {

  static func innerElse(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      } else {
        print("fallback")
      }
    }
  }
}

// MARK: - Case OuterElseBranch
enum Examples {

  static func outerElse(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      }
    } else {
      print("fallback")
    }
  }
}

// MARK: - Case StatementAfterInnerIf
enum Examples {

  static func after(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      }

      print("end")
    }
  }
}

// MARK: - Case StatementBeforeInnerIf
enum Examples {

  static func before(_ first: Bool, _ second: Bool) {
    if first {
      print("start")

      if second {
        print("ready")
      }
    }
  }
}
