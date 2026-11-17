// MARK: - Допустимые переносы операторов и их операндов (1)
enum Examples {

  // Комментарий перед оператором
  static func commented(_ first: Double, _ second: Double) -> Double {
    first
      // Keep the documented boundary.
      * second
  }

  // Оператор составного присваивания остаётся после изменяемого значения
  static func value(_ input: Int) -> Int {
    var value = input
    value +=
      input
    return value
  }

  // Составное присваивание многострочной строки
  static func multilineStringAssignment() -> String {
    var value = ""
    value +=
      """
      first
      second
      """
    return value
  }
}

// MARK: - Допустимые переносы операторов и их операндов (2)
enum Examples {

  // Деление после длинного выражения в аргументе
  static func longCall(_ first: Double, _ second: Double) -> Double {
    let result = Double(abs(max(abs(first), abs(second)))
      + abs(min(abs(first), abs(second)))
      + abs(max(abs(first), abs(second)))
      + abs(min(abs(first), abs(second)))
    ) / max(abs(first), abs(second))
    return result
  }

  // Деление после многострочного вызова
  static func multipleArguments(_ first: Double, _ second: Double) -> Double {
    max(
      first,
      second
    ) / 2
  }

  // Операнд с явными группирующими скобками
  static func grouped(_ first: Int, _ second: Int, _ third: Int) -> Int {
    (first + second) - third
  }

  // Короткое сравнение остаётся на одной строке
  static func value(_ first: Int, _ second: Int) -> Bool {
    first == second
  }
}

// MARK: - Допустимые переносы операторов и их операндов (3)
enum Examples {

  // Короткое преобразование правого операнда
  static func rightConversion(_ first: Int, _ second: Int) -> Double {
    12 / Double(first - second)
  }

  // Группа с отрицанием перед делением
  static func unary(_ first: Double, _ second: Double) -> Double {
    let result = -(max(first.magnitude, second.magnitude) - min(first.magnitude, second.magnitude))
      / max(first.magnitude, second.magnitude)
    return result
  }

  // Короткое выражение с разным приоритетом операторов
  static func short(_ first: Double, _ second: Double) -> Double {
    first + second * 2
  }

  // Многострочная цепочка умножения и деления
  static func longProduct(_ first: Double, _ second: Double) -> Double {
    let result = max(first.magnitude, second.magnitude)
      * min(first.magnitude, second.magnitude)
      / max(first.magnitude, second.magnitude)
    return result
  }
}

// MARK: - Многострочное произведение внутри суммы
enum Examples {

  static func longAdditiveSegment(_ first: Double, _ second: Double) -> Double {
    let result = max(abs(first), abs(second))
      + abs(max(abs(first), abs(second)))
      * abs(min(abs(first), abs(second)))
      * abs(max(abs(first), abs(second)))
      * abs(min(abs(first), abs(second)))
    return result
  }
}
