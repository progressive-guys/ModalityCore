enum Examples {

  static func nestedArguments(_ argument: Int, _ first: Bool) -> Int {
    let result = if abs(
      abs(
        argument
      )
    ) > 0,
      first
    {
      1
    } else {
      0
    }
    return result
  }
}
