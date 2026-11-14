// MARK: - Case AdditiveTermAfterDivision
// MARK: Input
enum Examples {

  static func laterAdditiveTerm(_ first: Double, _ second: Double) -> Double {
    let result = max(first.magnitude, second.magnitude)
      / min(first.magnitude, second.magnitude) + max(first.magnitude, second.magnitude)
    return result
  }
}

// MARK: Output
enum Examples {

  static func laterAdditiveTerm(_ first: Double, _ second: Double) -> Double {
    let result = max(first.magnitude, second.magnitude) / min(first.magnitude, second.magnitude)
      + max(first.magnitude, second.magnitude)
    return result
  }
}

// MARK: - Case AdditiveTermAfterRemainder
// MARK: Input
enum Examples {

  static func splitRemainder(_ first: Int, _ second: Int) -> Int {
    let result = max(abs(first), abs(second), 1_000)
      % min(abs(first), abs(second), 1_000) + max(abs(first), abs(second), 1_000)
    return result
  }
}

// MARK: Output
enum Examples {

  static func splitRemainder(_ first: Int, _ second: Int) -> Int {
    let result = max(abs(first), abs(second), 1_000) % min(abs(first), abs(second), 1_000)
      + max(abs(first), abs(second), 1_000)
    return result
  }
}

// MARK: - Case ArithmeticInsideCompoundAssignment
// MARK: Input
func compound(_ first: Int, _ second: Int) -> Int {
  var value = first
  value += first +
    second
  return value
}

// MARK: Output
func compound(_ first: Int, _ second: Int) -> Int {
  var value = first
  value += first + second
  return value
}

// MARK: - Case BooleanChainWrapsAllTerms
// MARK: Input
enum Examples {
  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    first && second
      || third
  }
}

// MARK: Output
enum Examples {

  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    first
      && second
      || third
  }
}

// MARK: - Case ComparisonBeforeMultilineArray
// MARK: Input
enum Example {

  static func checkValues() {
    assert(
      [1, 2].map { $0 } == [
        1,
        2
      ]
    )
  }
}

// MARK: Output
enum Example {

  static func checkValues() {
    assert(
      [1, 2].map { $0 }
        == [
          1,
          2
        ]
    )
  }
}

// MARK: - Case ComparisonStartsContinuation
// MARK: Input
func comparison(_ first: Int, _ second: Int) -> Bool {
  first ==
    second
}

// MARK: Output
func comparison(_ first: Int, _ second: Int) -> Bool {
  first
    == second
}

// MARK: - Case CustomOperatorStartsContinuation
// MARK: Input
infix operator <+>: AdditionPrecedence

struct Value {
  let value: Int

  static func <+> (_ lhs: Self, _ rhs: Self) -> Self {
    Self(value: lhs.value + rhs.value)
  }
}

func combine(_ first: Value, _ second: Value) -> Value {
  first <+>
    second
}

// MARK: Output
infix operator <+>: AdditionPrecedence

struct Value {

  let value: Int

  static func <+> (_ lhs: Self, _ rhs: Self) -> Self {
    Self(value: lhs.value + rhs.value)
  }
}

func combine(_ first: Value, _ second: Value) -> Value {
  first
    <+> second
}

// MARK: - Case DivisionAfterCollapsedArgument
// MARK: Input
enum Operands {
  struct Item {
    let value: Int
  }

  struct Input {
    let item: Item
  }
}

enum Examples {

  static func computedValue(_ input: Operands.Input, _ second: Operands.Input, _ divisor: Int) -> Double {
    let result = Double(abs(input.item.value) -
      abs(second.item.value)) / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }
}

// MARK: Output
enum Operands {

  struct Item {
    let value: Int
  }

  struct Input {
    let item: Item
  }
}

enum Examples {

  static func computedValue(_ input: Operands.Input, _ second: Operands.Input, _ divisor: Int) -> Double {
    let result = Double(abs(input.item.value) - abs(second.item.value))
      / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }
}

// MARK: - Case ExpandedConversionBecomesSingleLine
// MARK: Input
enum Operands {
  struct Item {
    let value: Int
  }

  struct Input {
    let item: Item
  }
}

enum Examples {

  static func expandedConversion(_ input: Operands.Input, _ second: Operands.Input, _ divisor: Int) -> Double {
    let result = Double(
      abs(input.item.value) - abs(second.item.value)
    ) / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }
}

// MARK: Output
enum Operands {

  struct Item {
    let value: Int
  }

  struct Input {
    let item: Item
  }
}

enum Examples {

  static func expandedConversion(_ input: Operands.Input, _ second: Operands.Input, _ divisor: Int) -> Double {
    let result = Double(abs(input.item.value) - abs(second.item.value)) / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }
}

// MARK: - Case GroupedDifferenceBeforeDivision
// MARK: Input
enum Examples {

  static func wrongIndent(_ first: Double, _ second: Double) -> Double {
    let result = (max(first.magnitude, second.magnitude) -
        min(first.magnitude, second.magnitude)) / max(first.magnitude, second.magnitude)
    return result
  }
}

// MARK: Output
enum Examples {

  static func wrongIndent(_ first: Double, _ second: Double) -> Double {
    let result = (max(first.magnitude, second.magnitude) - min(first.magnitude, second.magnitude))
      / max(first.magnitude, second.magnitude)
    return result
  }
}

// MARK: - Case IsolatedAdditionCompacts
// MARK: Input
func value(_ first: Int, _ second: Int) -> Int {
  first
    +
    second
}

// MARK: Output
func value(_ first: Int, _ second: Int) -> Int {
  first + second
}

// MARK: - Case LeadingAdditionCompacts
// MARK: Input
func shortExpression(_ first: Double, _ second: Double) -> Double {
  first
    + second
}

// MARK: Output
func shortExpression(_ first: Double, _ second: Double) -> Double {
  first + second
}

// MARK: - Case LongNilCoalescingWraps
// MARK: Input
enum Examples {
  static func value(_ input: Int?,
    _ fallback: Int) -> Int {
    let result = input.flatMap { $0.isMultiple(of: 2) ? $0 : nil } ?? (fallback.isMultiple(of: 2) ? fallback : fallback + 1)
    return result
  }
}

// MARK: Output
enum Examples {

  static func value(_ input: Int?,
    _ fallback: Int) -> Int {
    let result = input.flatMap { $0.isMultiple(of: 2) ? $0 : nil }
      ?? (fallback.isMultiple(of: 2) ? fallback : fallback + 1)
    return result
  }
}

// MARK: - Case MixedAdditiveBreaksCompact
// MARK: Input
func value(_ first: Int, _ second: Int, _ third: Int) -> Int {
  first +
    second
    - third
}

// MARK: Output
func value(_ first: Int, _ second: Int, _ third: Int) -> Int {
  first + second - third
}

// MARK: - Case MixedMultiplicativeBreaksCompact
// MARK: Input
func value(_ first: Int, _ second: Int, _ third: Int) -> Int {
  first *
    second
    / third
}

// MARK: Output
func value(_ first: Int, _ second: Int, _ third: Int) -> Int {
  first * second / third
}

// MARK: - Case MultiplicationWithinAdditiveChain
// MARK: Input
enum Examples {

  static func splitProduct(_ first: Double, _ second: Double, _ third: Double, _ fourth: Double) -> Double {
    let result = max(abs(first), abs(second)) + min(abs(second), abs(third))
      * max(abs(third), abs(fourth)) - min(abs(first), abs(fourth))
    return result
  }
}

// MARK: Output
enum Examples {

  static func splitProduct(_ first: Double, _ second: Double, _ third: Double, _ fourth: Double) -> Double {
    let result = max(abs(first), abs(second))
      + min(abs(second), abs(third)) * max(abs(third), abs(fourth))
      - min(abs(first), abs(fourth))
    return result
  }
}

// MARK: - Case NilCoalescingChainWrapsAllTerms
// MARK: Input
enum Examples {
  static func value(_ first: Int?, _ second: Int?, _ third: Int) -> Int {
    first ?? second
      ?? third
  }
}

// MARK: Output
enum Examples {

  static func value(_ first: Int?, _ second: Int?, _ third: Int) -> Int {
    first
      ?? second
      ?? third
  }
}

// MARK: - Case NilCoalescingStartsContinuation
// MARK: Input
func fallback(_ first: Int?, _ second: Int) -> Int {
  first ??
    second
}

// MARK: Output
func fallback(_ first: Int?, _ second: Int) -> Int {
  first
    ?? second
}

// MARK: - Case NilCoalescingWithMemberOperand
// MARK: Input
enum Examples {
  static func value(_ first: Int?, _ second: (value: Int, other: Bool)) -> Int {
    first ??
      second.value
  }
}

// MARK: Output
enum Examples {

  static func value(_ first: Int?, _ second: (value: Int, other: Bool)) -> Int {
    first
      ?? second.value
  }
}

// MARK: - Case PartlyWrappedAdditiveChainCompacts
// MARK: Input
func partialLeading(_ first: Int, _ second: Int, _ third: Int) -> Int {
  first + second
    - third
}

// MARK: Output
func partialLeading(_ first: Int, _ second: Int, _ third: Int) -> Int {
  first + second - third
}

// MARK: - Case RangeStartsContinuation
// MARK: Input
func range(_ first: Int, _ second: Int) -> ClosedRange<Int> {
  first ...
    second
}

// MARK: Output
func range(_ first: Int, _ second: Int) -> ClosedRange<Int> {
  first
    ... second
}

// MARK: - Case RightConversionCollapsesBeforeDivision
// MARK: Input
enum Example {

  static func fraction(_ pitch: Int, _ referencePitch: Int, _ octaveSubdivisions: Int) -> Double {
    let distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch = Double(pitch - referencePitch) / Double(
      octaveSubdivisions
    )
    return distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch
  }
}

// MARK: Output
enum Example {

  static func fraction(_ pitch: Int, _ referencePitch: Int, _ octaveSubdivisions: Int) -> Double {
    let distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch = Double(pitch - referencePitch)
      / Double(octaveSubdivisions)
    return distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch
  }
}

// MARK: - Case ShortArithmeticInsideConversion
// MARK: Input
func shortConversion(_ first: Int, _ second: Int) -> Double {
  Double(first -
    second) / 12
}

// MARK: Output
func shortConversion(_ first: Int, _ second: Int) -> Double {
  Double(first - second) / 12
}

// MARK: - Case ShortRightCallCompacts
// MARK: Input
func sum(_ first: Int, _ second: Int) -> Int {
  first + abs(
    second
  )
}

// MARK: Output
func sum(_ first: Int, _ second: Int) -> Int {
  first + abs(second)
}

// MARK: - Case TrailingAdditionCompacts
// MARK: Input
func trailing(_ first: Int, _ second: Int) -> Int {
  first +
    second
}

// MARK: Output
func trailing(_ first: Int, _ second: Int) -> Int {
  first + second
}
