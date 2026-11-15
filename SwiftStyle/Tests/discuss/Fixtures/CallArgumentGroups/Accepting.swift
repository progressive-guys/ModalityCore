// MARK: - Аргумент ссылается на подготовленное значение
func log(message: Int) {}

func run(input: Int, sink: (Int) -> Void) {
  let value = input
  log(message: value)

  let next = value + 1
  sink(next)
}

// MARK: - Обычный аргумент рядом с аргументом inout
func pair(_ other: inout Int, _ value: Int) {}

func run(input: Int, sink: (Int) -> Void) {
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

// MARK: - Явный захват аргумента связывает значение с вызовом; следующее объявление отделено
func run(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
  let value = input
  visit { [copy = value] in copy }

  let next = value + 1
  sink(next)
}

// MARK: - Инициализатор с явным захватом отделён от предыдущего вызова
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = { [copy = value] in copy + 1 }
  sink(next())
}

// MARK: - Интерполяция читает локальное значение
func run(input: Int, say: (String) -> Void, sink: (Int) -> Void) {
  let value = input
  say("\(value)")

  let next = value + 1
  sink(next)
}

// MARK: - Вложенный вызов внутри аргумента
func run(input: Int, sink: (Int) -> Void) {
  let value: (Int) -> Int = abs
  sink(value(input))

  let next = value(input + 1)
  sink(next)
}

// MARK: - Объект вложенного вызова внутри аргумента
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value.distance(to: input))

  let next = value + 1
  sink(next)
}

// MARK: - Локальное значение из внешней области видимости
func run(input: Int, sink: @escaping (Int) -> Void) {
  let value = input
  let visit = {
    sink(value)

    let next = value + 1
    sink(next)
    sink(next)
  }

  visit()
}

// MARK: - Объявление после вызова с параметром отделено пустой строкой
func run(input: Int, sink: (Int) -> Void) {
  let preceding = input
  sink(preceding)
  sink(input)

  let next = input + 1
  sink(next)
}
