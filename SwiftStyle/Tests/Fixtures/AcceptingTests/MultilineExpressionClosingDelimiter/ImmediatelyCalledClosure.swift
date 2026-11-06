enum Examples {

  static func invokedClosure(_ first: Int) -> Int {
    Int({
      first
    }())
  }
}
