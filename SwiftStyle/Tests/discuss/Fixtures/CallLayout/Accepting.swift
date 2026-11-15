// MARK: - Вызов с тремя аргументами и пустой строкой после него

enum Examples {

  static func value() -> String {
    let value = "a".replacingOccurrences(
      of: "a",
      with: "b",
      options: .literal
    )

    return value
  }
}

// MARK: - Вызов с двумя аргументами и пустой строкой после него
enum Examples {

  static func value() -> String {
    let value = String(
      repeating: "a",
      count: 2
    )

    return value
  }
}

// MARK: - Вызов с двумя аргументами без пустой строки после него
enum Examples {

  static func value() -> String {
    let value = String(
      repeating: "a",
      count: 2
    )
    return value
  }
}
