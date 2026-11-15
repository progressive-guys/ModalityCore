// MARK: - Обращение к свойству в левом операнде соединяется с основанием
enum Example {

  static func firstOperand(_ input: (first: Int, second: Int)) -> Int {
    input
      .first + input.second
  }
}

/// Output
enum Example {

  static func firstOperand(_ input: (first: Int, second: Int)) -> Int {
    input.first + input.second
  }
}

// MARK: - Удаление лишнего отступа цепочки после многострочного основания
func adjusted(_ values: [Int]) -> [Int] {
  values.map {
    $0 + 1
  }
    .filter { $0 > 0 }
}

/// Output
func adjusted(_ values: [Int]) -> [Int] {
  values.map {
    $0 + 1
  }
  .filter { $0 > 0 }
}

// MARK: - Обращение к свойству в правом операнде соединяется с основанием
enum Example {

  static func secondOperand(_ input: (first: Int, second: Int)) -> Int {
    input.first + input
      .second
  }
}

/// Output
enum Example {

  static func secondOperand(_ input: (first: Int, second: Int)) -> Int {
    input.first + input.second
  }
}
