// MARK: - Input
enum Examples {

  static func process(_ values: [Int], identifier: Int) {
    let requestID = identifier

    values.forEach { value in
      print(requestID, value)
    }
  }
}

// MARK: - Output
enum Examples {

  static func process(_ values: [Int], identifier: Int) {
    let requestID = identifier
    values.forEach { value in
      print(requestID, value)
    }
  }
}
