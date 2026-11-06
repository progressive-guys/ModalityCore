enum Examples {

  static func closure(_ values: [Int]) -> [Int] {
    values.map({ value in
      value + 1
    })
  }
}
