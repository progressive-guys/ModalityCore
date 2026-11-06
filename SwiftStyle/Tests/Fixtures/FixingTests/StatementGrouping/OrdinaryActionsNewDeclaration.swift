// MARK: - Input
enum Examples {

  static func update(_ input: Int, values: inout [Int]) {
    let first = input
    values.append(first)
    let second = input + 1
    values.append(second)
  }
}

// MARK: - Output
enum Examples {

  static func update(_ input: Int, values: inout [Int]) {
    let first = input
    values.append(first)

    let second = input + 1
    values.append(second)
  }
}
