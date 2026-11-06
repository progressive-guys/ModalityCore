enum Examples {

  static func update(_ input: Int, first: inout [Int], second: inout [Int]) {
    let value = input
    first.append(value)

    second.append(value)
    second.sort()
  }
}
