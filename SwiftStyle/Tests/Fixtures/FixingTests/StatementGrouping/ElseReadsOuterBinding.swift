// MARK: - Input
enum Examples {

  static func process(_ input: Int?, alternative: Int?) {
    let value = input

    if let value = alternative {
      print(value)
    } else {
      print(value as Any)
    }
  }
}

// MARK: - Output
enum Examples {

  static func process(_ input: Int?, alternative: Int?) {
    let value = input
    if let value = alternative {
      print(value)
    } else {
      print(value as Any)
    }
  }
}
