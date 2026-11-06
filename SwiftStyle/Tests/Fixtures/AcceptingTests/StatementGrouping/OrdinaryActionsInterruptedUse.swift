enum Examples {

  static func update(_ input: Int, values: inout [Int]) {
    let value = input

    values.removeAll()
    values.append(value)
    values.sort()
  }
}
