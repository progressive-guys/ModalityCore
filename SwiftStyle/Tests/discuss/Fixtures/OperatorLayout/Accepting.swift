// MARK: - Комментарий перед оператором
enum Examples {

  static func commented(_ first: Double, _ second: Double) -> Double {
    first
      // Keep the documented boundary.
      * second
  }
}

// MARK: - Оператор составного присваивания остаётся после изменяемого значения
enum Examples {

  static func value(_ input: Int) -> Int {
    var value = input
    value +=
      input
    return value
  }
}

// MARK: - Составное присваивание многострочной строки
enum Examples {

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

// MARK: - Деление после длинного выражения в аргументе
enum Examples {

  static func longCall(_ first: Double, _ second: Double) -> Double {
    let result = Double(abs(max(abs(first), abs(second)))
      + abs(min(abs(first), abs(second)))
      + abs(max(abs(first), abs(second)))
      + abs(min(abs(first), abs(second)))
    ) / max(abs(first), abs(second))
    return result
  }
}

// MARK: - Деление после многострочного вызова
enum Examples {

  static func multipleArguments(_ first: Double, _ second: Double) -> Double {
    max(
      first,
      second
    ) / 2
  }
}

// MARK: - Операнд с явными группирующими скобками
enum Examples {

  static func grouped(_ first: Int, _ second: Int, _ third: Int) -> Int {
    (first + second) - third
  }
}

// MARK: - Короткое сравнение остаётся на одной строке
enum Examples {

  static func value(_ first: Int, _ second: Int) -> Bool {
    first == second
  }
}

// MARK: - Короткое преобразование правого операнда
enum Examples {

  static func rightConversion(_ first: Int, _ second: Int) -> Double {
    12 / Double(first - second)
  }
}

// MARK: - Группа с отрицанием перед делением
enum Examples {

  static func unary(_ first: Double, _ second: Double) -> Double {
    let result = -(max(first.magnitude, second.magnitude) - min(first.magnitude, second.magnitude))
      / max(first.magnitude, second.magnitude)
    return result
  }
}

// MARK: - Короткое выражение с разным приоритетом операторов
enum Examples {

  static func short(_ first: Double, _ second: Double) -> Double {
    first + second * 2
  }
}

// MARK: - Многострочная цепочка умножения и деления
enum Examples {

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
