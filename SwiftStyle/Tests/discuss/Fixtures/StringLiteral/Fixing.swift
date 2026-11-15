// MARK: - Отступ многострочной строки в аргументе уменьшается до двух пробелов
func argument() {
  print(
    """
      first
      second
      """
  )
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

// MARK: - Отступ строки в вычисляемом свойстве уменьшается с сохранением вложенного отступа
var value: String {
  """
    first
      second
    """
}

/// Output
var value: String {
  """
  first
    second
  """
}

// MARK: - Отступ многострочного результата функции уменьшается до двух пробелов
func value() -> String {
  """
    first
    second
    """
}

/// Output
func value() -> String {
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
  static func value() -> String {
    #"first"# + #"second"#
  }
}

/// Output
enum Examples {

  static func value() -> String {
    "firstsecond"
  }
}

// MARK: - Отступы строки с продолжением уменьшаются с сохранением обратной косой черты
func lineContinuation(_ number: Int) -> String {
  """
    \(number) · rows: 2 · \
    scale: 3
    """
}

/// Output
func lineContinuation(_ number: Int) -> String {
  """
  \(number) · rows: 2 · \
  scale: 3
  """
}

// MARK: - Отступ строки с решётками и интерполяцией уменьшается до двух пробелов
func rawInterpolation(_ number: Int) -> String {
  #"""
    \path
    \#(number)
    """#
}

/// Output
func rawInterpolation(_ number: Int) -> String {
  #"""
  \path
  \#(number)
  """#
}

// MARK: - Отступы многострочного литерала уменьшаются, пустая строка получает отступ
func blankLinesAndIndentation() -> String {
  """
    first
      second

    last
    """
}

/// Output
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

// MARK: - Отступ многострочной строки в глобальной константе уменьшается до двух пробелов
let overIndented = """
    first
    """

/// Output
let overIndented = """
  first
  """

// MARK: - Строка с решётками соединяется с объявлением глобальной константы
let standaloneRaw =
  #"""
    first
    """#

/// Output
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
