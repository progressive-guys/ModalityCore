// MARK: - Accepted

infix operator <+>: AdditionPrecedence

enum Accepted {
  struct Value {
    let value: Int

    static func <+> (_ lhs: Self, _ rhs: Self) -> Self {
      Self(value: lhs.value + rhs.value)
    }
  }

  static func arithmetic(_ first: Int, _ second: Int) -> Int {
    first
      + second
  }

  static func comparison(_ first: Int, _ second: Int) -> Bool {
    first
      == second
  }

  static func logical(_ first: Bool, _ second: Bool) -> Bool {
    first
      && second
  }

  static func fallback(_ first: Int?, _ second: Int) -> Int {
    first
      ?? second
  }

  static func range(_ first: Int, _ second: Int) -> ClosedRange<Int> {
    first
      ... second
  }

  static func custom(_ first: Value, _ second: Value) -> Value {
    first
      <+> second
  }

  static func unary(_ first: Int) -> Int {
    -first
  }

  static func assignment(_ first: Int) -> Int {
    let value =
      first
    return value
  }

  static func compoundAssignment(_ input: Int) -> Int {
    var value = input
    value +=
      input
    value <<=
      input
    value |=
      input
    value &+=
      input
    return value
  }

  static func multilineStringAssignment() -> String {
    var value = ""
    value +=
      """
      first
      second
      """
    return value
  }

}

// MARK: - Rejected

enum Rejected {
  static func arithmetic(_ first: Int, _ second: Int) -> Int {
    first +
      second
  }

  static func comparison(_ first: Int, _ second: Int) -> Bool {
    first ==
      second
  }

  static func logical(_ first: Bool, _ second: Bool) -> Bool {
    first &&
      second
  }

  static func fallback(_ first: Int?, _ second: Int) -> Int {
    first ??
      second
  }

  static func range(_ first: Int, _ second: Int) -> ClosedRange<Int> {
    first ...
      second
  }

  static func custom(_ first: Accepted.Value, _ second: Accepted.Value) -> Accepted.Value {
    first <+>
      second
  }

  static func isolated(_ first: Int, _ second: Int) -> Int {
    first
      +
      second
  }

  static func compound(_ first: Int, _ second: Int) -> Int {
    var value = first
    value += first +
      second
    return value
  }
}
