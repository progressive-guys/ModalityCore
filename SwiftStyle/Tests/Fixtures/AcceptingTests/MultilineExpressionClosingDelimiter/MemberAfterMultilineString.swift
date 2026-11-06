enum Examples {

  static func multilineString() -> [UInt8] {
    Array("""
      first
      second
      """.utf8)
  }
}
