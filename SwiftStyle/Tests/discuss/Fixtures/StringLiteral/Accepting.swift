// MARK: - Пустые строки, явные переводы и return в многострочном литерале
enum Examples {

  // Пустая строка внутри литерала без отступа
  static func blankLinesAndIndentation() -> String {
    """
    first
      second

    last
    """
  }

  // Явный перевод строки препятствует сокращению литерала
  static func explicitNewline(_ text: String) -> String {
    """
    Hello \(text)\n
    """
  }

  // Строковый литерал после явного return
  static func inlineReturn() -> String {
    return """
      first
      second
      """
  }
}

// MARK: - Литеральные символы интерполяции и точки с запятой в строках
enum Examples {

  static let raw = #"""
    Hello \(text)
    """#

  static func status(_ failure: String?) -> String {
    var value = "a; return"
    if let failure {
      value = "Error: \(failure)"
      return value
    }
    return value
  }
}
