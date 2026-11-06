// MARK: - Input
enum Examples {
  static func value() -> String {
    """
      first
      second
      """
  }

  static let standaloneRaw =
    #"""
      first
      """#

  static func argument() {
    print(
      """
        first
        second
        """
    )
  }

  static let overIndented = """
      first
      """

  static func blankLinesAndIndentation() -> String {
    """
      first
        second

      last
      """
  }

  static func rawInterpolation(_ number: Int) -> String {
    #"""
      \path
      \#(number)
      """#
  }

  static func lineContinuation(_ number: Int) -> String {
    """
      \(number) · rows: 2 · \
      scale: 3
      """
  }

  static func tabs() -> String {
    """
	one
		two
	"""
  }
}

// MARK: - Output
enum Examples {

  static let standaloneRaw = #"""
    first
    """#

  static let overIndented = """
    first
    """

  static func value() -> String {
    """
    first
    second
    """
  }

  static func argument() {
    print(
      """
      first
      second
      """
    )
  }

  static func blankLinesAndIndentation() -> String {
    """
    first
      second
    
    last
    """
  }

  static func rawInterpolation(_ number: Int) -> String {
    #"""
    \path
    \#(number)
    """#
  }

  static func lineContinuation(_ number: Int) -> String {
    """
    \(number) · rows: 2 · \
    scale: 3
    """
  }

  static func tabs() -> String {
    """
    one
    	two
    """
  }
}
