// MARK: - Комментарий и объединение подготовленных значений начинают отдельные группы
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let value = input
  // Prepare another value.
  let next = other
  let sum = value + next
  sink(sum)
}

/// Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let value = input

  // Prepare another value.
  let next = other

  let sum = value + next
  sink(sum)
}

// MARK: - Вызов с данными двух подготовленных групп отделяется пустой строкой
func run(input: Int, other: Int, sink: (Int) -> Void) {
  var first = [input]
  first.append(1)

  var second = [other]
  second.append(2)
  sink(first.count + second.count)
}

/// Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  var first = [input]
  first.append(1)

  var second = [other]
  second.append(2)

  sink(first.count + second.count)
}

// MARK: - Обращение к раннему значению сохраняет группу объявлений; итоговый вызов отделяется
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let base = input
  let count = other
  let scaled = base * 2

  let width = other + 1
  sink(scaled + count + width)
}

/// Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let base = input
  let count = other
  let scaled = base * 2

  let width = other + 1

  sink(scaled + count + width)
}

// MARK: - Независимое объявление отделяется от предыдущего и следующего этапов
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let base = input
  let scaled = base * 2
  let count = other
  let spacing = scaled / max(count, 1)
  sink(spacing)
}

/// Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let base = input
  let scaled = base * 2

  let count = other

  let spacing = scaled / max(count, 1)
  sink(spacing)
}

// MARK: - Независимые объявления объединяются общим использованием
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input

  let second = other
  let sum = first + second
  sink(sum)
}

/// Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input
  let second = other
  let sum = first + second
  sink(sum)
}

// MARK: - Объявление и return, объединяющий разные группы, отделяются пустыми строками
func run(input: Int, other: Int) -> Int {
  let value = input
  let scaled = value * 2
  let count = other
  return scaled + count
}

/// Output
func run(input: Int, other: Int) -> Int {
  let value = input
  let scaled = value * 2

  let count = other

  return scaled + count
}

// MARK: - Настройка разных объектов образует отдельные группы
final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

func run(input: Int) {
  let first = Node()
  first.first = input
  first.render()
  let second = Node()
  second.first = input
  second.render()
}

/// Output
final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

func run(input: Int) {
  let first = Node()
  first.first = input
  first.render()

  let second = Node()
  second.first = input
  second.render()
}
