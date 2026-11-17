// MARK: - Отступы строк в аргументе, свойстве и результате функции
func argument() {
  print(
    """
      first
      second
      """
  )
}

var value: String {
  """
    first
      second
    """
}

func returnedText() -> String {
  """
    first
    second
    """
}

/// Output
func argument() {
  print(
    """
    first
    second
    """
  )
}

var value: String {
  """
  first
    second
  """
}

func returnedText() -> String {
  """
  first
  second
  """
}

// MARK: - Объединение длинных литералов с продолжением строки
let longText = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz" + "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"

/// Output
let longText = """
  abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLM\
  NOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
  """

// MARK: - Объединение литералов с решётками и экранированием
let escaped = #"a\b"# + "\n\"quoted\""

/// Output
let escaped = "a\\b\n\"quoted\""

// MARK: - Объединение сцепленных строк с решётками
enum Examples {
  static func returnedText() -> String {
    #"first"# + #"second"#
  }
}

/// Output
enum Examples {

  static func returnedText() -> String {
    "firstsecond"
  }
}

// MARK: - Отступы строк с продолжением, интерполяцией и пустой строкой
func lineContinuation(_ number: Int) -> String {
  """
    \(number) · rows: 2 · \
    scale: 3
    """
}

func rawInterpolation(_ number: Int) -> String {
  #"""
    \path
    \#(number)
    """#
}

func blankLinesAndIndentation() -> String {
  """
    first
      second

    last
    """
}

/// Output
func lineContinuation(_ number: Int) -> String {
  """
  \(number) · rows: 2 · \
  scale: 3
  """
}

func rawInterpolation(_ number: Int) -> String {
  #"""
  \path
  \#(number)
  """#
}

func blankLinesAndIndentation() -> String {
  """
  first
    second
  
  last
  """
}

// MARK: - Многострочная запись одной строки с интерполяцией сокращается
enum Examples {
  static func value(_ text: String) -> String {
    """
    Hello \(text)
    """
  }
}

/// Output
enum Examples {

  static func value(_ text: String) -> String {
    "Hello \(text)"
  }
}

// MARK: - Переносы многострочных глобальных строковых констант
let overIndented = """
    first
    """

let standaloneRaw =
  #"""
    first
    """#

/// Output
let overIndented = """
  first
  """

let standaloneRaw = #"""
  first
  """#

// MARK: - Общий отступ табуляцией заменяется пробелами, вложенная табуляция сохраняется
func tabs() -> String {
  """
	one
		two
	"""
}

/// Output
func tabs() -> String {
  """
  one
  	two
  """
}
