// MARK: - Объявление соединяется с выражением if
enum Examples {
  static func value(_ first: Bool) -> Int {
    let
      result = if first { 1 } else { 0 }
    return result
  }
}

/// Output
enum Examples {

  static func value(_ first: Bool) -> Int {
    let result = if first {
        1
      } else {
        0
      }
    return result
  }
}

// MARK: - Открывающая скобка перед однострочным return
enum Examples {
  static func value(_ first: Bool, _ second: Bool) -> Bool {
    if first,
      second { return true }
    return false
  }
}

/// Output
enum Examples {

  static func value(_ first: Bool, _ second: Bool) -> Bool {
    if first,
      second
    { return true }

    return false
  }
}

// MARK: - Скобка тела на строке закрытия вызова в условии
enum Examples {
  static func value(_ values: [Int], _ value: Int) -> Bool {
    if values.contains(
      value
    )
    { return true }
    return false
  }
}

/// Output
enum Examples {

  static func value(_ values: [Int], _ value: Int) -> Bool {
    if values.contains(
      value
    ) { return true }

    return false
  }
}

// MARK: - Продолжение шаблона case выравнивается; перед default добавляется пустая строка
func select(_ value: Int) -> Int {
  switch value {
  case 1,
       2: 1
  default: 0
  }
}

/// Output
func select(_ value: Int) -> Int {
  switch value {
  case 1,
    2: 1

  default: 0
  }
}

// MARK: - После сокращения guard удаляется пустая строка
func value(_ first: Bool) -> Int {
  guard first else {
    return 0
  }

  return 1
}

/// Output
func value(_ first: Bool) -> Int {
  guard first else { return 0 }
  return 1
}

// MARK: - Продолжение условия if выравнивается, значения веток переносятся
enum Examples {
  static func value(_ first: Bool, _ second: Bool) -> Int {
    let result = if first,
                    second
    { 1 } else { 0 }
    return result
  }
}

/// Output
enum Examples {

  static func value(_ first: Bool, _ second: Bool) -> Int {
    let result = if first,
      second
    {
      1
    } else {
      0
    }
    return result
  }
}

// MARK: - Однострочный return и многострочное действие в else
func value(_ first: Bool) -> Void {
  if first { return } else { print("value") }
}

/// Output
func value(_ first: Bool) -> Void {
  if first { return } else {
    print("value")
  }
}
