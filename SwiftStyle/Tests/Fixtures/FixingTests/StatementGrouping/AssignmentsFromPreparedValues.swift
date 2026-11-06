// MARK: - Input
enum Examples {

  static func configure(_ left: inout [Int], right: inout [Int]) {
    var first = [0]
    first.append(1)

    var second = [0]
    second.append(2)

    left = first

    right = first + second
  }
}

// MARK: - Output
enum Examples {

  static func configure(_ left: inout [Int], right: inout [Int]) {
    var first = [0]
    first.append(1)

    var second = [0]
    second.append(2)

    left = first
    right = first + second
  }
}
