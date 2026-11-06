enum Examples {

  static func longAdditiveSegment(_ first: Double, _ second: Double) -> Double {
    let result = max(abs(first), abs(second))
      + abs(max(abs(first), abs(second)))
      * abs(min(abs(first), abs(second)))
      * abs(max(abs(first), abs(second)))
      * abs(min(abs(first), abs(second)))
    return result
  }
}
