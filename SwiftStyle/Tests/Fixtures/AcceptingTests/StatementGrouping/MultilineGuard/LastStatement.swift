enum Examples {

  static func process(_ input: Int?) {
    guard
      let value = input,
      value > 0
    else { return }
  }
}
