// MARK: - Input
enum Examples {

  static func process(_ values: [Int]) {
    let completion: (Int) -> Void = { value in
      print(value)
    }

    values.forEach(completion)
  }
}

// MARK: - Output
enum Examples {

  static func process(_ values: [Int]) {
    let completion: (Int) -> Void = { value in
      print(value)
    }
    values.forEach(completion)
  }
}
