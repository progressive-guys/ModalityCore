// MARK: - Вложенные if объединяются с сохранением привязки значения
enum Example {

  static func binding(_ value: Int?) {
    if let value {
      if value > 0 { print(value) }
    }
  }
}

/// Output
enum Example {

  static func binding(_ value: Int?) {
    if let value,
       value > 0
    {
      print(value)
    }
  }
}

// MARK: - При объединении if сохраняется комментарий после закрывающей скобки
func run(_ first: Bool, _ second: Bool, body: () -> Void) {
  if first {
    if second {
      body()
    } // Keep this closing comment.
  }
}

/// Output
func run(_ first: Bool, _ second: Bool, body: () -> Void) {
  if first,
     second
  {
    body()
  } // Keep this closing comment.
}

// MARK: - При объединении if комментарий переносится между условиями
enum Example {

  static func comments(_ first: Bool, _ second: Bool) {
    if first {
      // Check the next condition only after the first one succeeds.
      if second { print("ready") }
    }
  }
}

/// Output
enum Example {

  static func comments(_ first: Bool, _ second: Bool) {
    if first,
      // Check the next condition only after the first one succeeds.
       second
    {
      print("ready")
    }
  }
}

// MARK: - Три вложенных if объединяются в список условий
enum Example {

  static func threeLevels(_ first: Bool, _ second: Bool, _ third: Bool) {
    if first {
      if second {
        if third { print("ready") }
      }
    }
  }
}

/// Output
enum Example {

  static func threeLevels(_ first: Bool, _ second: Bool, _ third: Bool) {
    if first,
       second,
       third
    {
      print("ready")
    }
  }
}

// MARK: - Два вложенных if объединяются в список условий
enum Example {

  static func nested(_ first: Bool, _ second: Bool) {
    if first {
      if second {
        print("ready")
      }
    }
  }
}

/// Output
enum Example {

  static func nested(_ first: Bool, _ second: Bool) {
    if first,
       second
    {
      print("ready")
    }
  }
}
