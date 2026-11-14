// MARK: - Case AdjacentCases
// MARK: Input
enum Value {
  case first

  case second
}

// MARK: Output
enum Value {
  case first
  case second
}

// MARK: - Case MultilineAssociatedValues
// MARK: Input
enum Value {

  case first(
    Int,
    String
  )
  case second
}

// MARK: Output
enum Value {

  case first(
    Int,
    String
  )

  case second
}
