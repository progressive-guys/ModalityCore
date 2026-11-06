enum Examples {

  static func rawMultilineString() -> [UInt8] {
    Array(#"""
      first
      second
      """#.utf8)
  }
}
