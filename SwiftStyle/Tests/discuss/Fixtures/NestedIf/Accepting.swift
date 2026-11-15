// MARK: - Ветви и соседние инструкции препятствуют объединению if (1)
enum Examples {

  // У вложенного if есть ветка else
  static func innerElse(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      } else {
        print("fallback")
      }
    }
  }

  // У внешнего if есть ветка else
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

// MARK: - Ветви и соседние инструкции препятствуют объединению if (2)
enum Examples {

  // Инструкция после вложенного if
  static func after(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      }

      print("end")
    }
  }

  // Инструкция перед вложенным if
  static func before(_ first: Bool, _ second: Bool) {
    if first {
      print("start")

      if second {
        print("ready")
      }
    }
  }
}
