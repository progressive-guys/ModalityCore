// MARK: - Input
enum Examples {

  static func process(_ input: Int) {
    let completion = {
      print(input)

      print("done")
    }
    completion()
  }
}

// MARK: - Output
enum Examples {

  static func process(_ input: Int) {
    let completion = {
      print(input)
      print("done")
    }
    completion()
  }
}
