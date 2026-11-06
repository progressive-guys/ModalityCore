infix operator <+>: AdditionPrecedence

enum Examples {

  struct Value {

    let value: Int

    static func <+> (_ lhs: Self, _ rhs: Self) -> Self {
      Self(value: lhs.value + rhs.value)
    }
  }

  static func custom(_ first: Value, _ second: Value) -> Value {
    first
      <+> second
  }
}
