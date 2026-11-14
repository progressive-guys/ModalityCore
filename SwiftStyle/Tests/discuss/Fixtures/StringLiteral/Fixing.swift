// MARK: - Case CallArgumentMargin
// MARK: Input
func argument() {
  print(
    """
      first
      second
      """
  )
}

// MARK: Output
func argument() {
  print(
    """
    first
    second
    """
  )
}

// MARK: - Case ComputedPropertyMargin
// MARK: Input
var value: String {
  """
    first
      second
    """
}

// MARK: Output
var value: String {
  """
  first
    second
  """
}

// MARK: - Case FunctionResultMargin
// MARK: Input
func value() -> String {
  """
    first
    second
    """
}

// MARK: Output
func value() -> String {
  """
  first
  second
  """
}

// MARK: - Case JoinLongLiteralsWithContinuation
// MARK: Input
let longText = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz" + "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"

// MARK: Output
let longText = """
  abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLM\
  NOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
  """

// MARK: - Case JoinRawAndEscapedLiterals
// MARK: Input
let escaped = #"a\b"# + "\n\"quoted\""

// MARK: Output
let escaped = "a\\b\n\"quoted\""

// MARK: - Case JoinRawLiteralConcatenation
// MARK: Input
enum Examples {
  static func value() -> String {
    #"first"# + #"second"#
  }
}

// MARK: Output
enum Examples {
  static func value() -> String {
    "firstsecond"
  }
}

// MARK: - Case LineContinuationMargin
// MARK: Input
func lineContinuation(_ number: Int) -> String {
  """
    \(number) · rows: 2 · \
    scale: 3
    """
}

// MARK: Output
func lineContinuation(_ number: Int) -> String {
  """
  \(number) · rows: 2 · \
  scale: 3
  """
}

// MARK: - Case RawInterpolationMargin
// MARK: Input
func rawInterpolation(_ number: Int) -> String {
  #"""
    \path
    \#(number)
    """#
}

// MARK: Output
func rawInterpolation(_ number: Int) -> String {
  #"""
  \path
  \#(number)
  """#
}

// MARK: - Case RelativeIndentAndBlankLineMargin
// MARK: Input
func blankLinesAndIndentation() -> String {
  """
    first
      second

    last
    """
}

// MARK: Output
func blankLinesAndIndentation() -> String {
  """
  first
    second
  
  last
  """
}

// MARK: - Case SingleLineInterpolation
// MARK: Input
enum Examples {
  static func value(_ text: String) -> String {
    """
    Hello \(text)
    """
  }
}

// MARK: Output
enum Examples {
  static func value(_ text: String) -> String {
    "Hello \(text)"
  }
}

// MARK: - Case StoredLiteralMargin
// MARK: Input
let overIndented = """
    first
    """

// MARK: Output
let overIndented = """
  first
  """

// MARK: - Case StoredRawLiteralJoinsBinding
// MARK: Input
let standaloneRaw =
  #"""
    first
    """#

// MARK: Output
let standaloneRaw = #"""
  first
  """#

// MARK: - Case TabMargin
// MARK: Input
func tabs() -> String {
  """
	one
		two
	"""
}

// MARK: Output
func tabs() -> String {
  """
  one
  	two
  """
}
