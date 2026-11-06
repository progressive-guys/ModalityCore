// MARK: - Input
enum Examples {

  static func process(_ input: Int, candidate: Int) {
    let value = input

    if case value = candidate {
      print("matched")
    }
  }
}

// MARK: - Output
enum Examples {

  static func process(_ input: Int, candidate: Int) {
    let value = input
    if case value = candidate {
      print("matched")
    }
  }
}
