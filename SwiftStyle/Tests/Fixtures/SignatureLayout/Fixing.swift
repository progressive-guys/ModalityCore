// MARK: - Компоновка полного имени, стрелки и кортежа возвращаемого типа
enum Examples {

  struct Result { }
  static func qualifiedResult() -> Examples
    .Result { .init() }

  static func scalarResult()
    -> Int { 1 }

  static func tupleResult() -> (
    Int, Int
  ) { (1, 2) }
}

/// Output
enum Examples {

  struct Result { }

  static func qualifiedResult() -> Examples.Result {
    .init()
  }

  static func scalarResult() -> Int {
    1
  }

  static func tupleResult() -> (Int, Int) {
    (1, 2)
  }
}
