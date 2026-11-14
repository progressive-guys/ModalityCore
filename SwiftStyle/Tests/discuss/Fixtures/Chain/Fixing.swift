// MARK: - Case LeftBinaryOperand
// MARK: Input
enum Example {

  static func firstOperand(_ input: (first: Int, second: Int)) -> Int {
    input
      .first + input.second
  }
}

// MARK: Output
enum Example {

  static func firstOperand(_ input: (first: Int, second: Int)) -> Int {
    input.first + input.second
  }
}

// MARK: - Case MultilineBaseRemovesExtraIndent
// MARK: Input
func adjusted(_ values: [Int]) -> [Int] {
  values.map {
    $0 + 1
  }
    .filter { $0 > 0 }
}

// MARK: Output
func adjusted(_ values: [Int]) -> [Int] {
  values.map {
    $0 + 1
  }
  .filter { $0 > 0 }
}

// MARK: - Case RightBinaryOperand
// MARK: Input
enum Example {

  static func secondOperand(_ input: (first: Int, second: Int)) -> Int {
    input.first + input
      .second
  }
}

// MARK: Output
enum Example {

  static func secondOperand(_ input: (first: Int, second: Int)) -> Int {
    input.first + input.second
  }
}
