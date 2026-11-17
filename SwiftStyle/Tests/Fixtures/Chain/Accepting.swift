// MARK: - Продолжение цепочки после однострочного основания
func adjusted(_ values: [Int]) -> [Int] {
  values.map { $0 + 1 }
    .filter { $0 > 0 }
}

// MARK: - Обращения к свойствам в левом и правом операндах соединяются с основанием
enum Example {

  static func firstOperand(_ input: (first: Int, second: Int)) -> Int {
    // Если не помещается в строку
    input.first
      + input.second
  }

  static func secondOperand(_ input: (first: Int, second: Int)) -> Int {
    input.first + input.second
  }
}
