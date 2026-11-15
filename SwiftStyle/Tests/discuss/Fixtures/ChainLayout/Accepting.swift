// MARK: - Комментарии и отступы в цепочках вызовов
enum Examples {

  // Комментарий между объектом и продолжением цепочки
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

  // Отступ аргументов после цепочки вызовов
  static func value(_ values: [Int], _ value: Int) -> Bool {
    values.sorted()
      .contains(
        value
      )
  }

  // Отступ замыкания после цепочки вызовов
  static func value(_ values: [Int]) -> [Int] {
    values.map { $0 + 1 }
      .filter { value in
        value > 0
      }
  }
}
