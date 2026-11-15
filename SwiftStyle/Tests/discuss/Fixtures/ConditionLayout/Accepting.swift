// MARK: - Условие с вызовом у массива сохраняет скобку тела на отдельной строке
enum Examples {

  static func arrayLiteral(_ value: String) -> Bool {
    if [
      "first", "second"
    ].contains(value)
    { return true }

    return false
  }
}

// MARK: - Тело выражения if выровнено по объявлению
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

// MARK: - Вложенный вызов в условии выражения if
enum Examples {

  static func nestedArguments(_ argument: Int, _ first: Bool) -> Int {
    let result = if abs(
      abs(
        argument
      )
    ) > 0,
      first
    {
      1
    } else {
      0
    }
    return result
  }
}
