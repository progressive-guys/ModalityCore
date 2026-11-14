// MARK: - Case AdjacentTypeAliases
// MARK: Input
enum Instrument {
  typealias Fret = Int

  typealias String = Int

  typealias Tuning = [Int]
}

// MARK: Output
enum Instrument {

  typealias Fret = Int
  typealias String = Int
  typealias Tuning = [Int]
}

// MARK: - Case AfterMultilineFunction
// MARK: Input
struct MultilineMethod {

  func a() -> Int {
    1
  }
  func b() -> Int { 2 }
}

// MARK: Output
struct MultilineMethod {

  func a() -> Int {
    1
  }

  func b() -> Int { 2 }
}

// MARK: - Case GetterBeforeMethod
// MARK: Input
struct GetterBeforeMethod {

  var x: Int {
    1
  }
  func read() -> Int { x }
}

// MARK: Output
struct GetterBeforeMethod {

  var x: Int {
    1
  }

  func read() -> Int { x }
}

// MARK: - Case InlineFunctions
// MARK: Input
struct Methods {
  func first() -> Int { 1 }

  func second() -> Int { 2 }
}

// MARK: Output
struct Methods {

  func first() -> Int { 1 }
  func second() -> Int { 2 }
}

// MARK: - Case InlineProtocolRequirements
// MARK: Input
protocol Worker {
  func start()

  func stop()
}

// MARK: Output
protocol Worker {

  func start()
  func stop()
}

// MARK: - Case MultilineProtocolRequirement
// MARK: Input
protocol Worker {

  func first(
    value: Int
  )
  func second()
}

// MARK: Output
protocol Worker {

  func first(
    value: Int
  )

  func second()
}

// MARK: - Case NestedTypeBeforeProperty
// MARK: Input
struct Value {

  enum Key {
    case value
  }
  let value: Int
}

// MARK: Output
struct Value {

  enum Key {
    case value
  }

  let value: Int
}
