// MARK: - Input
enum Examples {

  static func process(_ input: Int) {
    let value = input

    let completion = { [captured = value] in
      print(captured)
    }
    completion()
  }
}

// MARK: - Output
enum Examples {

  static func process(_ input: Int) {
    let value = input
    let completion = { [captured = value] in
      print(captured)
    }
    completion()
  }
}
