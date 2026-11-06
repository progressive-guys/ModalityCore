// MARK: - Input
enum Examples {
  static func firstOperand(_ input: (first: Int, second: Int)) -> Int {
    input
      .first + input.second
  }

  static func secondOperand(_ input: (first: Int, second: Int)) -> Int {
    input.first + input
      .second
  }
}

// MARK: - Output
enum Examples {

  static func firstOperand(_ input: (first: Int, second: Int)) -> Int {
    input.first + input.second
  }

  static func secondOperand(_ input: (first: Int, second: Int)) -> Int {
    input.first + input.second
  }
}
