enum Examples {

  static func repeatExcluded(_ value: Int) {
    repeat {
      print(value)
    } while abs(abs(value)) > 0
  }
}
