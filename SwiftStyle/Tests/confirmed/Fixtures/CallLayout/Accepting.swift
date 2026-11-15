// MARK: - Пустая строка после вызова с двумя и тремя аргументами
enum Examples {

  static func threeArguments() -> String {
    let value = "a".replacingOccurrences(
      of: "a",
      with: "b",
      options: .literal
    )

    return value
  }

  static func twoArgumentsWithGap() -> String {
    let value = String(
      repeating: "a",
      count: 2
    )

    return value
  }

  static func twoArgumentsWithoutGap() -> String {
    let value = String(
      repeating: "a",
      count: 2
    )
    return value
  }
}
