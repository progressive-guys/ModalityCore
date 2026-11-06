enum Examples {

  static func forBinding(_ values: [Int]) {
    for value in values
    where abs(abs(value)) > 0 {
      print(value)
    }
  }
}
