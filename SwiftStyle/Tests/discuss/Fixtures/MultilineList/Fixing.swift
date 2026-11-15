// MARK: - Первый аргумент вложенного вызова переносится на новую строку
func value() -> String {
  let value = String(
    repeating: "a",
    // This comment does not add an argument code line.
    count: max(1,
      2)
  )

  return value
}

/// Output
func value() -> String {
  let value = String(
    repeating: "a",
    // This comment does not add an argument code line.
    count: max(
      1,
      2
    )
  )

  return value
}

// MARK: - Параметры многострочной сигнатуры размещаются по одному на строке
func total(
  first: Int, second: Int
) -> Int {
  first + second
}

/// Output
func total(
  first: Int,
  second: Int
) -> Int {
  first + second
}
