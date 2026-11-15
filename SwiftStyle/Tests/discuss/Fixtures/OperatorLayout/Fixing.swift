// MARK: - Сложение отделяется от целого произведения или остатка
enum Examples {

  static func laterAdditiveTerm(_ first: Double, _ second: Double) -> Double {
    let result = max(first.magnitude, second.magnitude)
      / min(first.magnitude, second.magnitude) + max(first.magnitude, second.magnitude)
    return result
  }

  static func splitRemainder(_ first: Int, _ second: Int) -> Int {
    let result = max(abs(first), abs(second), 1_000)
      % min(abs(first), abs(second), 1_000) + max(abs(first), abs(second), 1_000)
    return result
  }
}

/// Output
enum Examples {

  static func laterAdditiveTerm(_ first: Double, _ second: Double) -> Double {
    let result = max(first.magnitude, second.magnitude) / min(first.magnitude, second.magnitude)
      + max(first.magnitude, second.magnitude)
    return result
  }

  static func splitRemainder(_ first: Int, _ second: Int) -> Int {
    let result = max(abs(first), abs(second), 1_000) % min(abs(first), abs(second), 1_000)
      + max(abs(first), abs(second), 1_000)
    return result
  }
}

// MARK: - Правая часть составного присваивания сокращается до одной строки
func compound(_ first: Int, _ second: Int) -> Int {
  var value = first
  value += first +
    second
  return value
}

/// Output
func compound(_ first: Int, _ second: Int) -> Int {
  var value = first
  value += first + second
  return value
}

// MARK: - Все части логической цепочки переносятся вместе
enum Examples {
  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    first && second
      || third
  }
}

/// Output
enum Examples {

  static func value(_ first: Bool, _ second: Bool, _ third: Bool) -> Bool {
    first
      && second
      || third
  }
}

// MARK: - Сравнение с многострочным массивом начинается на новой строке
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

/// Output
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

// MARK: - Оператор сравнения начинает строку продолжения
func comparison(_ first: Int, _ second: Int) -> Bool {
  first ==
    second
}

/// Output
func comparison(_ first: Int, _ second: Int) -> Bool {
  first
    == second
}

// MARK: - Пользовательский оператор начинает строку продолжения
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

/// Output
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

// MARK: - Сокращение аргумента и многострочного преобразования перед делением
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

  static func expandedConversion(_ input: Operands.Input, _ second: Operands.Input, _ divisor: Int) -> Double {
    let result = Double(
      abs(input.item.value) - abs(second.item.value)
    ) / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }
}

/// Output
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

  static func expandedConversion(_ input: Operands.Input, _ second: Operands.Input, _ divisor: Int) -> Double {
    let result = Double(abs(input.item.value) - abs(second.item.value)) / Double(max(abs(divisor), abs(input.item.value)))
    return result
  }
}

// MARK: - Разность в скобках соединяется на одной строке, деление переносится
enum Examples {

  static func wrongIndent(_ first: Double, _ second: Double) -> Double {
    let result = (max(first.magnitude, second.magnitude) -
        min(first.magnitude, second.magnitude)) / max(first.magnitude, second.magnitude)
    return result
  }
}

/// Output
enum Examples {

  static func wrongIndent(_ first: Double, _ second: Double) -> Double {
    let result = (max(first.magnitude, second.magnitude) - min(first.magnitude, second.magnitude))
      / max(first.magnitude, second.magnitude)
    return result
  }
}

// MARK: - Короткие суммы, разности, произведения и деления остаются на одной строке
enum Expressions {

  static func sum(_ first: Int, _ second: Int) -> Int {
    first
      +
      second
  }

  static func shortSum(_ first: Double, _ second: Double) -> Double {
    first
      + second
  }

  static func additive(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first +
      second
      - third
  }

  static func multiplicative(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first *
      second
      / third
  }

  static func partialLeading(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first + second
      - third
  }
}

/// Output
enum Expressions {

  static func sum(_ first: Int, _ second: Int) -> Int {
    first + second
  }

  static func shortSum(_ first: Double, _ second: Double) -> Double {
    first + second
  }

  static func additive(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first + second - third
  }

  static func multiplicative(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first * second / third
  }

  static func partialLeading(_ first: Int, _ second: Int, _ third: Int) -> Int {
    first + second - third
  }
}

// MARK: - Длинное выражение с оператором ?? переносится
enum Examples {
  static func value(_ input: Int?,
    _ fallback: Int) -> Int {
    let result = input.flatMap { $0.isMultiple(of: 2) ? $0 : nil } ?? (fallback.isMultiple(of: 2) ? fallback : fallback + 1)
    return result
  }
}

/// Output
enum Examples {

  static func value(_ input: Int?,
    _ fallback: Int) -> Int {
    let result = input.flatMap { $0.isMultiple(of: 2) ? $0 : nil }
      ?? (fallback.isMultiple(of: 2) ? fallback : fallback + 1)
    return result
  }
}

// MARK: - Согласованные переносы цепочек операторов
enum Examples {

  static func splitProduct(_ first: Double, _ second: Double, _ third: Double, _ fourth: Double) -> Double {
    let result = max(abs(first), abs(second)) + min(abs(second), abs(third))
      * max(abs(third), abs(fourth)) - min(abs(first), abs(fourth))
    return result
  }

  static func value(_ first: Int?, _ second: Int?, _ third: Int) -> Int {
    first ?? second
      ?? third
  }
}

/// Output
enum Examples {

  static func splitProduct(_ first: Double, _ second: Double, _ third: Double, _ fourth: Double) -> Double {
    let result = max(abs(first), abs(second))
      + min(abs(second), abs(third)) * max(abs(third), abs(fourth))
      - min(abs(first), abs(fourth))
    return result
  }

  static func value(_ first: Int?, _ second: Int?, _ third: Int) -> Int {
    first
      ?? second
      ?? third
  }
}

// MARK: - Оператор ?? начинает строку продолжения
func fallback(_ first: Int?, _ second: Int) -> Int {
  first ??
    second
}

/// Output
func fallback(_ first: Int?, _ second: Int) -> Int {
  first
    ?? second
}

// MARK: - Оператор ?? переносится перед обращением к свойству
enum Examples {
  static func value(_ first: Int?, _ second: (value: Int, other: Bool)) -> Int {
    first ??
      second.value
  }
}

/// Output
enum Examples {

  static func value(_ first: Int?, _ second: (value: Int, other: Bool)) -> Int {
    first
      ?? second.value
  }
}

// MARK: - Оператор диапазона начинает строку продолжения
func range(_ first: Int, _ second: Int) -> ClosedRange<Int> {
  first ...
    second
}

/// Output
func range(_ first: Int, _ second: Int) -> ClosedRange<Int> {
  first
    ... second
}

// MARK: - Преобразование делителя сокращается, оператор деления переносится
enum Example {

  static func fraction(_ pitch: Int, _ referencePitch: Int, _ octaveSubdivisions: Int) -> Double {
    let distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch = Double(pitch - referencePitch) / Double(
      octaveSubdivisions
    )
    return distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch
  }
}

/// Output
enum Example {

  static func fraction(_ pitch: Int, _ referencePitch: Int, _ octaveSubdivisions: Int) -> Double {
    let distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch = Double(pitch - referencePitch)
      / Double(octaveSubdivisions)
    return distanceBetweenTheCurrentlyObservedPitchAndTheReferencePitch
  }
}

// MARK: - Арифметика внутри преобразования типа сокращается до одной строки
func shortConversion(_ first: Int, _ second: Int) -> Double {
  Double(first -
    second) / 12
}

/// Output
func shortConversion(_ first: Int, _ second: Int) -> Double {
  Double(first - second) / 12
}

// MARK: - Короткий вызов справа сокращается до одной строки
func sum(_ first: Int, _ second: Int) -> Int {
  first + abs(
    second
  )
}

/// Output
func sum(_ first: Int, _ second: Int) -> Int {
  first + abs(second)
}

// MARK: - Сложение с оператором в конце строки сокращается до одной строки
func trailing(_ first: Int, _ second: Int) -> Int {
  first +
    second
}

/// Output
func trailing(_ first: Int, _ second: Int) -> Int {
  first + second
}
