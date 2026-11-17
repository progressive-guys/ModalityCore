// MARK: - Переносы объявления и условий if
enum Examples {

  static func value(_ first: Bool) -> Int {
    let
      result = if first { 1 } else { 0 }
    return result
  }

  static func value(_ first: Bool, _ second: Bool) -> Bool {
    if first,
      second { return true }
    return false
  }

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

  static func value(_ first: Bool) -> Int {
    let result = if first {
        1
      } else {
        0
      }

    return result
  }

  static func value(_ first: Bool, _ second: Bool) -> Bool {
    if first,
      second
    {
      return true
    }

    return false
  }

  static func value(_ values: [Int], _ value: Int) -> Bool {
    if values.contains(
      value
    ) {
      return true
    }

    return false
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

// MARK: - Продолжение условия if получает отступ в два пробела, значения веток переносятся
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
