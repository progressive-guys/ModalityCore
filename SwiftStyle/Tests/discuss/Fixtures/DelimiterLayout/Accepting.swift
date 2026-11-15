// MARK: - Закрывающие скобки при вложенных выражениях (1)
enum Examples {

  // Соседние закрывающие скобки
  static func nestedClosingDelimiters(_ first: Int, _ second: Int) -> Double {
    Double(max(
      first,
      second
    ))
  }

  // Приведение типа после многострочного массива
  static func castCollection(_ first: Int) -> [Int] {
    ([
      first
    ] as [Int]).map { $0 }
  }

  // Замыкание в аргументе вызова
  static func closure(_ values: [Int]) -> [Int] {
    values.map({ value in
      value + 1
    })
  }
}

// MARK: - Закрывающие скобки при вложенных выражениях (2)
enum Examples {

  // Немедленный вызов замыкания
  static func invokedClosure(_ first: Int) -> Int {
    Int({
      first
    }())
  }

  // Обращение к члену типа после многострочного вызова
  static func nestedMember(_ values: [Int]) -> Bool {
    Bool(Array(
      values
    ).isEmpty)
  }

  // Обращение к члену типа после многострочной строки
  static func multilineString() -> [UInt8] {
    Array("""
      first
      second
      """.utf8)
  }
}

// MARK: - Закрывающие скобки при вложенных выражениях (3)
enum Examples {

  // Обращение к члену типа после многострочной строки с решётками
  static func rawMultilineString() -> [UInt8] {
    Array(#"""
      first
      second
      """#.utf8)
  }

  // Следующий аргумент после массива
  static func remainingArgument(_ first: Int, _ second: Int) -> [[Int]] {
    Array(repeating: [
      first,
      second
    ], count: 2)
  }
}
