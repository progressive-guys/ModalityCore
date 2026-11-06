// MARK: - Input
enum Examples {

  static func update(_ first: inout [Int], second: inout [Int]) {
    first.removeAll()

    second.sort()

    first.append(0)
  }
}

// MARK: - Output
enum Examples {

  static func update(_ first: inout [Int], second: inout [Int]) {
    first.removeAll()
    second.sort()
    first.append(0)
  }
}
