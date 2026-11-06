enum Examples {

  static func bindingCondition(_ values: [Int: Int], _ value: Int) -> Int {
    if let result = values[value + 1 + 2] { return result }
    return 0
  }
}
