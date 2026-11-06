enum Examples {

  static func longCall(_ first: Double, _ second: Double) -> Double {
    let result = Double(abs(max(abs(first), abs(second)))
      + abs(min(abs(first), abs(second)))
      + abs(max(abs(first), abs(second)))
      + abs(min(abs(first), abs(second)))
    ) / max(abs(first), abs(second))
    return result
  }
}
