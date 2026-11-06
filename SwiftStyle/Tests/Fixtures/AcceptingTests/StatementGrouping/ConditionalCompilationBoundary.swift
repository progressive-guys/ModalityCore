enum Examples {

  static func process(_ input: Int) {
    let value = input

    #if os(macOS)
    print(value)
    #endif

    print(value)
    print(value + 1)
  }
}
