enum Examples {

  static func unary(_ first: Double, _ second: Double) -> Double {
    let result = -(max(first.magnitude, second.magnitude) - min(first.magnitude, second.magnitude))
      / max(first.magnitude, second.magnitude)
    return result
  }
}
