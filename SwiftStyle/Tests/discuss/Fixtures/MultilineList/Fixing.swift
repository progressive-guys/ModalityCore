// MARK: - Первый элемент и параметры многострочных списков
func value() -> String {
  let value = String(
    repeating: "a",
    // This comment does not add an argument code line.
    count: max(1,
      2)
  )

  return value
}

func total(
  first: Int, second: Int
) -> Int {
  first + second
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

func total(
  first: Int,
  second: Int
) -> Int {
  first + second
}
