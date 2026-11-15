// MARK: - Идентификатор в обратных кавычках
enum Examples {

  static func backticks(_ `default`: Int) -> Bool {
    if `default` > 0 { return true }
    return false
  }
}

// MARK: - Содержимое литералов и комментариев сохраняется побайтно
func text() -> String {
  // Keep  two spaces and punctuation: (, ).
  return #"value :  [a, b]"#
}

// MARK: - Вложенная многострочная интерполяция
let nested = """
value: \(
  """
  inner
  """
)
end
"""

// MARK: - Сохранение регулярного выражения и идентификатора Unicode
enum Examples {

  static var regex: Regex<(Substring, Substring)> { #/if check(value)/# }

  static func unicode(_ значение: Int) -> Bool {
    if значение > 0 { return true }
    return false
  }
}

// MARK: - Строка с составным Unicode-символом сохраняется без завершающего переноса
let decomposed = "Café"