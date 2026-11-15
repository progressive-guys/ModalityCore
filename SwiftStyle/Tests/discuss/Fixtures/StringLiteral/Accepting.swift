// MARK: - Пустая строка внутри литерала без отступа
enum Examples {

  static func blankLinesAndIndentation() -> String {
    """
    first
      second

    last
    """
  }
}

// MARK: - Явный перевод строки препятствует сокращению литерала
enum Examples {

  static func explicitNewline(_ text: String) -> String {
    """
    Hello \(text)\n
    """
  }
}

// MARK: - Строковый литерал после явного return
enum Examples {

  static func inlineReturn() -> String {
    return """
      first
      second
      """
  }
}

// MARK: - Текст, похожий на интерполяцию, в строке с решётками
enum Examples {

  static let raw = #"""
    Hello \(text)
    """#
}

// MARK: - Точка с запятой внутри строкового литерала
enum Examples {

  static func status(_ failure: String?) -> String {
    var value = "a; return"
    if let failure {
      value = "Error: \(failure)"
      return value
    }
    return value
  }
}
