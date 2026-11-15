// MARK: - После вызова через локальную функцию разрыв перед её копированием удаляется
func run(input: Int, sink: (Int) -> Void) {
  let value = sink
  value(input)

  let next = value
  next(input)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = sink
  value(input)
  let next = value
  next(input)
}

// MARK: - Вызов с чтением значения в теле замыкания отделяется от следующего объявления
func run(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
  let value = input
  visit { value }
  let next = value + 1
  sink(next)
}

/// Output
func run(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
  let value = input
  visit { value }
  
  let next = value + 1
  sink(next)
}

// MARK: - Пустая строка перед инициализацией замыкания без явного захвата удаляется
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = { value + 1 }
  sink(next())
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = { value + 1 }
  sink(next())
}

// MARK: - Пустая строка перед локальным вычисляемым свойством удаляется
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  var next: Int { value + 1 }
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  var next: Int { value + 1 }
  sink(next)
}

// MARK: - Guard отделяется от предыдущей группы объявлений и вызовов
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    guard value > 0 else { return }
    sink(value)
  }
}

/// Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    guard value > 0 else { return }
    sink(value)
  }
}

// MARK: - If отделяется от предыдущей группы объявлений и вызовов
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    if value > 0 {
      sink(value)
    }

    sink(input)
  }
}

/// Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    if value > 0 {
      sink(value)
    }

    sink(input)
  }
}

// MARK: - Пустая строка перед инициализацией через if удаляется; следующий вызов отделяется
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = if input > 0 {
    value
  } else {
    0
  }
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = if input > 0 {
    value
  } else {
    0
  }

  sink(next)
}

// MARK: - Независимое выражение начинает новую группу
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = input + 1
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = input + 1
  sink(next)
}

// MARK: - Объявление, читающее две подготовленные группы, отделяется пустой строкой
func run(input: Int, sink: (Int) -> Void) {
  let first = input
  sink(first)

  let second = input + 1
  sink(second)
  let next = second + first
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let first = input
  sink(first)

  let second = input + 1
  sink(second)

  let next = second + first
  sink(next)
}

// MARK: - После вызова с inout разрыв перед производным объявлением удаляется
func touch(_ value: inout Int) { value += 1 }

func run(input: Int, sink: (Int) -> Void) {
  var value = input
  touch(&value)

  let next = value + 1
  sink(next)
}

/// Output
func touch(_ value: inout Int) { value += 1 }

func run(input: Int, sink: (Int) -> Void) {
  var value = input
  touch(&value)
  let next = value + 1
  sink(next)
}

// MARK: - Совпадение имени с компонентом KeyPath не сохраняет разрыв перед объявлением
struct Box {
  let value: Int }

func log(_ path: KeyPath<Box, Int>, _ value: Int) {}

func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(\Box.value, other)

  let next = value + 1
  sink(next)
}

/// Output
struct Box {
  let value: Int }

func log(_ path: KeyPath<Box, Int>, _ value: Int) {}

func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(\Box.value, other)
  let next = value + 1
  sink(next)
}

// MARK: - Совпадение имени с меткой аргумента не сохраняет разрыв перед объявлением
func log(value: Int) {}

func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(value: other)

  let next = value + 1
  sink(next)
}

/// Output
func log(value: Int) {}

func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(value: other)
  let next = value + 1
  sink(next)
}

// MARK: - Комментарий перед выражением начинает новую группу
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  // Next calculation.
  let next = abs(value)
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  // Next calculation.
  let next = abs(value)
  sink(next)
}

// MARK: - Совпадение имени со свойством другого объекта не сохраняет разрыв
struct Box {
  let value: Int }

func pair(_ a: Int, _ b: Int) {}

func run(input: Int, box: Box, sink: (Int) -> Void) {
  let value = input
  let other = input
  pair(box.value, other)

  let next = value + 1
  sink(next)
}

/// Output
struct Box {
  let value: Int }

func pair(_ a: Int, _ b: Int) {}

func run(input: Int, box: Box, sink: (Int) -> Void) {
  let value = input
  let other = input
  pair(box.value, other)
  let next = value + 1
  sink(next)
}

// MARK: - Пустая строка перед вызовом с многострочным производным значением удаляется
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    let next = abs(
      value
    )

    sink(next)
  }
}

/// Output
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    let next = abs(
      value
    )

    sink(next)
  }
}

// MARK: - Пустая строка перед производным объявлением после многострочного вызова удаляется
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(
    value
  )

  let next = value + 1
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(
    value
  )
  let next = value + 1
  sink(next)
}

// MARK: - Пустая строка перед объявлением нескольких значений удаляется
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = value, ignored = input
  sink(next + ignored)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = value, ignored = input
  sink(next + ignored)
}

// MARK: - После вызова с псевдонимом разрыв перед использованием исходного значения удаляется
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let alias = value
  sink(alias)

  let next = abs(value)
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let alias = value
  sink(alias)
  let next = abs(value)
  sink(next)
}

// MARK: - Две пустые строки перед производным объявлением сокращаются до одной
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)


  let next = value + 1
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = value + 1
  sink(next)
}

// MARK: - Ранний вызов не сохраняет разделитель перед производным объявлением
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input + 1
  sink(value)
  sink(other)

  let next = value + 1
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input + 1
  sink(value)
  sink(other)
  let next = value + 1
  sink(next)
}

// MARK: - После вызова метода разрыв перед чтением свойства того же объекта удаляется
func run(input: Int, sink: (Int) -> Void) {
  var value: [Int] = []
  value.append(input)

  let next = value.count
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  var value: [Int] = []
  value.append(input)
  let next = value.count
  sink(next)
}

// MARK: - Пустая строка перед return со связанным значением удаляется
func run(input: Int, sink: (Int) -> Void) -> Int {
  let value = input
  let copy = value + 1
  sink(copy)

  return abs(copy)
}

/// Output
func run(input: Int, sink: (Int) -> Void) -> Int {
  let value = input
  let copy = value + 1
  sink(copy)
  return abs(copy)
}

// MARK: - Затенённое имя параметра замыкания не сохраняет разрыв перед объявлением
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  sink([other].map { value in value }.count)

  let next = value + 1
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  sink([other].map { value in value }.count)
  let next = value + 1
  sink(next)
}

// MARK: - Тело из трёх инструкций не содержит пустых строк
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = abs(value)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = abs(value)
}

// MARK: - Пустая строка перед объявлением через кортежный шаблон удаляется
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let (next, _) = (value, input)
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let (next, _) = (value, input)
  sink(next)
}
