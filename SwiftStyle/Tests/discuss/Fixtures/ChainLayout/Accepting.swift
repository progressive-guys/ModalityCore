// MARK: - Комментарий между объектом и продолжением цепочки
enum Examples {

  static func values() -> [Int] {
    Array(
      repeating: 1,
      count: 2
    )
      // Keep this comment with the transformation.
      .map { value in
        value + 1
      }
  }
}

// MARK: - Отступ аргументов после цепочки вызовов
enum Examples {

  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted()
      .contains(
        value
      )
  }
}

// MARK: - Отступ замыкания после цепочки вызовов
enum Examples {

  static func value(_ values: [Int]) -> [Int] {
    values.map { $0 + 1 }
      .filter { value in
        value > 0
      }
  }
}
