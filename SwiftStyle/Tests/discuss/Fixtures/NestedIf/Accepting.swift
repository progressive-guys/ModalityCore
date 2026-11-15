// MARK: - У вложенного if есть ветка else
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

// MARK: - У внешнего if есть ветка else
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

// MARK: - Инструкция после вложенного if
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

// MARK: - Инструкция перед вложенным if
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
