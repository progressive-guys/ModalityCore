// MARK: - Input
enum Example {
  static var value: String {
    """
      first
        second
      """
  }

  static let raw =
    #"""
      \path
      """#

  static func consume() {
    print(
      """
        first
        second
        """
    )
  }
}

// MARK: - Output
enum Example {

  static let raw = #"""
    \path
    """#

  static var value: String {
    """
    first
      second
    """
  }

  static func consume() {
    print(
      """
      first
      second
      """
    )
  }
}
