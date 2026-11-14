// MARK: - Case QualifiedReturnTypeCompacts
// MARK: Input
enum Examples {
  struct Result {}
  static func value() -> Examples
    .Result { .init() }
}

// MARK: Output
enum Examples {

  struct Result {}

  static func value() -> Examples.Result { .init() }
}

// MARK: - Case ReturnArrowJoinsSignature
// MARK: Input
enum Examples {
  static func value()
    -> Int { 1 }
}

// MARK: Output
enum Examples {
  static func value() -> Int { 1 }
}

// MARK: - Case TupleReturnTypeCompacts
// MARK: Input
enum Examples {
  static func value() -> (
    Int, Int
  ) { (1, 2) }
}

// MARK: Output
enum Examples {
  static func value() -> (Int, Int) { (1, 2) }
}
