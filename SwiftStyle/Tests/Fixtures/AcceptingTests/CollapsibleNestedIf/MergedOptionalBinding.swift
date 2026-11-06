enum Examples {

  static func mergedBinding(_ value: Int?) {
    if let value, value > 0 {
      print(value)
    }
  }
}
