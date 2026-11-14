// MARK: - Case NestedCallBeforeFirst
// MARK: Input
func value() -> String {
  let value = String(
    repeating: "a",
    // This comment does not add an argument code line.
    count: max(1,
      2)
  )

  return value
}

// MARK: Output
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

// MARK: - Case SeparateAlreadyMultilineParameters
// MARK: Input
func total(
  first: Int, second: Int
) -> Int {
  first + second
}

// MARK: Output
func total(
  first: Int,
  second: Int
) -> Int {
  first + second
}
