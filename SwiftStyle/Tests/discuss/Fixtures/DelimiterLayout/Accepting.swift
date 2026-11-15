// MARK: - Соседние закрывающие скобки
enum Examples {

  static func nestedClosingDelimiters(_ first: Int, _ second: Int) -> Double {
    Double(max(
      first,
      second
    ))
  }
}

// MARK: - Приведение типа после многострочного массива
enum Examples {

  static func castCollection(_ first: Int) -> [Int] {
    ([
      first
    ] as [Int]).map { $0 }
  }
}

// MARK: - Замыкание в аргументе вызова
enum Examples {

  static func closure(_ values: [Int]) -> [Int] {
    values.map({ value in
      value + 1
    })
  }
}

// MARK: - Немедленный вызов замыкания
enum Examples {

  static func invokedClosure(_ first: Int) -> Int {
    Int({
      first
    }())
  }
}

// MARK: - Обращение к члену типа после многострочного вызова
enum Examples {

  static func nestedMember(_ values: [Int]) -> Bool {
    Bool(Array(
      values
    ).isEmpty)
  }
}

// MARK: - Обращение к члену типа после многострочной строки
enum Examples {

  static func multilineString() -> [UInt8] {
    Array("""
      first
      second
      """.utf8)
  }
}

// MARK: - Обращение к члену типа после многострочной строки с решётками
enum Examples {

  static func rawMultilineString() -> [UInt8] {
    Array(#"""
      first
      second
      """#.utf8)
  }
}

// MARK: - Следующий аргумент после массива
enum Examples {

  static func remainingArgument(_ first: Int, _ second: Int) -> [[Int]] {
    Array(repeating: [
      first,
      second
    ], count: 2)
  }
}
