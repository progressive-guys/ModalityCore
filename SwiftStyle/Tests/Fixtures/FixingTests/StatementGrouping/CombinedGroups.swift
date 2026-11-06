// MARK: - Input
enum Examples {

  static func process() {
    var first = [1]
    first.append(2)

    var second = [3]
    second.append(4)
    print(first, second)
    print(first.count, second.count)
  }
}

// MARK: - Output
enum Examples {

  static func process() {
    var first = [1]
    first.append(2)

    var second = [3]
    second.append(4)

    print(first, second)
    print(first.count, second.count)
  }
}
