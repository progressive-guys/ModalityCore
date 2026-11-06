// MARK: - Input
infix operator <+>: AdditionPrecedence

enum Operands {
  struct Value {
    let value: Int

    static func <+> (_ lhs: Self, _ rhs: Self) -> Self {
      Self(value: lhs.value + rhs.value)
    }
  }

}


enum Examples {
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

  static func custom(_ first: Operands.Value, _ second: Operands.Value) -> Operands.Value {
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

// MARK: - Output
infix operator <+>: AdditionPrecedence

enum Operands {

  struct Value {

    let value: Int

    static func <+> (_ lhs: Self, _ rhs: Self) -> Self {
      Self(value: lhs.value + rhs.value)
    }
  }

}


enum Examples {

  static func arithmetic(_ first: Int, _ second: Int) -> Int {
    first + second
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

  static func custom(_ first: Operands.Value, _ second: Operands.Value) -> Operands.Value {
    first
      <+> second
  }

  static func isolated(_ first: Int, _ second: Int) -> Int {
    first + second
  }

  static func compound(_ first: Int, _ second: Int) -> Int {
    var value = first
    value += first + second
    return value
  }
}
