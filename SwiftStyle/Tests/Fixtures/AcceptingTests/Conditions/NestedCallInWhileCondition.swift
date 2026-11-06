enum Examples {
  static func whileExcluded(_ value: Int) {
    while abs(abs(value)) > 0 { return }
  }
}
