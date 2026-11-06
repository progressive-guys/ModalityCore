// MARK: - Input
enum Example {
  static func value(_ firstInput: Double, _ secondInput: Double) -> Double {
    let result = Double(abs(firstInput.magnitude) -
      abs(secondInput.magnitude)) / Double(max(abs(firstInput.magnitude), abs(secondInput.magnitude)))
    return result
  }
}

// MARK: - Output
enum Example {

  static func value(_ firstInput: Double, _ secondInput: Double) -> Double {
    let result = Double(abs(firstInput.magnitude) - abs(secondInput.magnitude))
      / Double(max(abs(firstInput.magnitude), abs(secondInput.magnitude)))
    return result
  }
}
