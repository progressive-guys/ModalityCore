// MARK: - Input
enum Examples {

  static func process(_ input: [Int]) {
    var values = input

    while !values.isEmpty {
      print(values.removeLast())
    }
  }
}

// MARK: - Output
enum Examples {

  static func process(_ input: [Int]) {
    var values = input
    while !values.isEmpty {
      print(values.removeLast())
    }
  }
}
