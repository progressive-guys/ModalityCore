enum Examples {

  static func longFirstLine(_ first: Double, _ second: Double) -> Double {
    let result = Double(max(first.magnitude, second.magnitude)
      - min(first.magnitude, second.magnitude)
      + max(first.magnitude, second.magnitude)
    ) / 12
    return result
  }
}
