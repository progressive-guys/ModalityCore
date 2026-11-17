// MARK: - Обычные аргументы и inout ссылаются на подготовленные значения
// Аргумент ссылается на подготовленное значение
func log(message: Int) { }

func ordinaryArgument(input: Int, sink: (Int) -> Void) {
  let value = input
  log(message: value)

  let next = value + 1
  sink(next)
}

// Обычный аргумент рядом с аргументом inout
func pair(_ other: inout Int, _ value: Int) { }

func inoutArgument(input: Int, sink: (Int) -> Void) {
  var other = 0
  let value = input
  pair(&other, value)

  let next = value + 1
  sink(next)
}

// MARK: - Производное объявление после связанного вызова отделено пустой строкой
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    let next = abs(value)
    let sum = next + value
    sink(sum)
  }
}

// MARK: - Связи аргументов, захватов и вложенных вызовов с объявлениями (1)
// Явный захват аргумента связывает значение с вызовом; следующее объявление отделено
func capturedArgument(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
  let value = input
  visit { [copy = value] in copy }

  let next = value + 1
  sink(next)
}

// Инициализатор с явным захватом отделён от предыдущего вызова
func capturedInitializer(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = { [copy = value] in copy + 1 }
  sink(next())
}

// Интерполяция читает локальное значение
func interpolatedArgument(input: Int, say: (String) -> Void, sink: (Int) -> Void) {
  let value = input
  say("\(value)")

  let next = value + 1
  sink(next)
}

// MARK: - Связи аргументов, захватов и вложенных вызовов с объявлениями (2)
// Вложенный вызов внутри аргумента
func nestedCall(input: Int, sink: (Int) -> Void) {
  let value: (Int) -> Int = abs
  sink(value(input))

  let next = value(input + 1)
  sink(next)
}

// Объект вложенного вызова внутри аргумента
func receiverArgument(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value.distance(to: input))

  let next = value + 1
  sink(next)
}

// MARK: - Связи аргументов, захватов и вложенных вызовов с объявлениями (3)
// Локальное значение из внешней области видимости
func outerScope(input: Int, sink: @escaping (Int) -> Void) {
  let value = input
  let visit = {
    sink(value)

    let next = value + 1
    sink(next)
    sink(next)
  }

  visit()
}

// Объявление после вызова с параметром отделено пустой строкой
func followingDeclaration(input: Int, sink: (Int) -> Void) {
  let preceding = input
  sink(preceding)
  sink(input)

  let next = input + 1
  sink(next)
}
