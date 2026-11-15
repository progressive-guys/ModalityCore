// MARK: - Соседние присваивания идут подряд
func configure(_ state: inout (displayLink: Int, callbackTarget: Int, isRunning: Bool, lastError: String?)) {
  state.displayLink = 1
  state.callbackTarget = 2

  state.isRunning = true
  state.lastError = nil
}

/// Output
func configure(_ state: inout (displayLink: Int, callbackTarget: Int, isRunning: Bool, lastError: String?)) {
  state.displayLink = 1
  state.callbackTarget = 2
  state.isRunning = true
  state.lastError = nil
}

// MARK: - Серия присваиваний важнее связей с группами подготовки
func configure(_ left: inout [Int], right: inout [Int]) {
  var first = [0]
  first.append(1)

  var second = [0]
  second.append(2)

  left = first

  right = first + second
}

/// Output
func configure(_ left: inout [Int], right: inout [Int]) {
  var first = [0]
  first.append(1)

  var second = [0]
  second.append(2)

  left = first
  right = first + second
}

// MARK: - Между серией вызовов и серией присваиваний добавляется пустая строка
final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

func run(node: Node) {
  node.touch()
  node.render()
  node.first = 1
  node.second = 2
}

/// Output
final class Node {

  var first = 0
  var second = 0

  func apply(_ value: Int) {}
  func render() {}
  func touch() {}
}

func run(node: Node) {
  node.touch()
  node.render()

  node.first = 1
  node.second = 2
}

// MARK: - Явный захват соединяет объявление замыкания с подготовленным значением
func process(_ input: Int) {
  let value = input

  let completion = { [captured = value] in
    print(captured)
  }
  completion()
}

/// Output
func process(_ input: Int) {
  let value = input
  let completion = { [captured = value] in
    print(captured)
  }
  completion()
}

// MARK: - Чтение в теле замыкания убирает разрыв перед вызовом forEach
func process(_ values: [Int], identifier: Int) {
  let requestID = identifier

  values.forEach { value in
    print(requestID, value)
  }
}

/// Output
func process(_ values: [Int], identifier: Int) {
  let requestID = identifier
  values.forEach { value in
    print(requestID, value)
  }
}

// MARK: - Чтение во вложенном switch соединяет замыкание с подготовленным значением
func label(_ kind: Int, center: Int) {
  let angle = center + 90

  let completion = {
    switch kind {
    case 0: print("label", angle)
    default: print("circular", angle)
    }
  }
  completion()
}

/// Output
func label(_ kind: Int, center: Int) {
  let angle = center + 90
  let completion = {
    switch kind {
    case 0: print("label", angle)
    default: print("circular", angle)
    }
  }
  completion()
}

// MARK: - Пустая строка между объявлением замыкания и передачей его в аргумент удаляется
func process(_ values: [Int]) {
  let completion: (Int) -> Void = { value in
    print(value)
  }

  values.forEach(completion)
}

/// Output
func process(_ values: [Int]) {
  let completion: (Int) -> Void = { value in
    print(value)
  }
  values.forEach(completion)
}

// MARK: - Вызов объявленного замыкания отделяется пустой строкой
func run(input: Int, other: Int, sink: @escaping (Int) -> Void) {
  let callback: () -> Void = {
    sink(input)
  }
  callback()
}

/// Output
func run(input: Int, other: Int, sink: @escaping (Int) -> Void) {
  let callback: () -> Void = {
    sink(input)
  }

  callback()
}

// MARK: - Условное изменение коллекции соединяется с её объявлением
func headers(_ extra: [String]) -> [String] {
  var fields = ["default"]

  if !extra.isEmpty {
    fields.append(contentsOf: extra)
  }
  return fields
}

/// Output
func headers(_ extra: [String]) -> [String] {
  var fields = ["default"]
  if !extra.isEmpty {
    fields.append(contentsOf: extra)
  }
  return fields
}

// MARK: - Чтение внешнего значения в else убирает разрыв перед if
func process(_ input: Int?, alternative: Int?) {
  let value = input

  if let value = alternative {
    print(value)
  } else {
    print(value as Any)
  }
}

/// Output
func process(_ input: Int?, alternative: Int?) {
  let value = input
  if let value = alternative {
    print(value)
  } else {
    print(value as Any)
  }
}

// MARK: - Использование локального значения в шаблоне if case убирает разрыв
func process(_ input: Int, candidate: Int) {
  let value = input

  if case value = candidate {
    print("matched")
  }
}

/// Output
func process(_ input: Int, candidate: Int) {
  let value = input
  if case value = candidate {
    print("matched")
  }
}

// MARK: - Привязка guard продолжает группу
func process(_ input: Int?) {
  let candidate = input

  guard let value = candidate else { return }
  print(value)
  print(value + 1)
}

/// Output
func process(_ input: Int?) {
  let candidate = input
  guard let value = candidate else { return }
  print(value)
  print(value + 1)
}

// MARK: - Guard соединяется с подготовкой по чтению в else и отделяется от следующего вызова
func process(_ input: Int, enabled: Bool) {
  let value = input

  guard enabled else {
    print(value)
    return
  }
  print(value)
}

/// Output
func process(_ input: Int, enabled: Bool) {
  let value = input
  guard enabled else {
    print(value)
    return
  }

  print(value)
}

// MARK: - Чтение подготовленного значения в ветках убирает разрыв перед if
func play(_ input: Int, high: Bool) {
  let volume = input

  if high {
    print(volume)
  } else {
    print(-volume)
  }
}

/// Output
func play(_ input: Int, high: Bool) {
  let volume = input
  if high {
    print(volume)
  } else {
    print(-volume)
  }
}

// MARK: - Независимый вызов отделяется от подготовки и итогового return
enum Examples {

  static func value() -> String {
    let value = String(
      repeating: "a",
      count: 2
    )
    print("done")
    return value
  }
}

/// Output
enum Examples {

  static func value() -> String {
    let value = String(
      repeating: "a",
      count: 2
    )

    print("done")

    return value
  }
}

// MARK: - Итоговый return отделяется от серии однострочных проверок
func missingGapBeforeReturn(_ x: Int) -> Int {
  if x == 0 { return 0 }
  if x < 0 { return -1 }
  if x == 1 { return 1 }
  return x
}

/// Output
func missingGapBeforeReturn(_ x: Int) -> Int {
  if x == 0 { return 0 }
  if x < 0 { return -1 }
  if x == 1 { return 1 }

  return x
}

// MARK: - Цикл for соединяется с объявлением используемой коллекции
func process(_ input: [Int]) {
  let values = input

  for value in values {
    print(value)
  }
}

/// Output
func process(_ input: [Int]) {
  let values = input
  for value in values {
    print(value)
  }
}

// MARK: - Многострочный if отделяется от соседних однострочных guard
func check(_ value: Int) {
  guard value > 0 else { return }
  if value == 1 {
    return
  }
  guard value < 10 else { return }
}

/// Output
func check(_ value: Int) {
  guard value > 0 else { return }

  if value == 1 {
    return
  }

  guard value < 10 else { return }
}

// MARK: - Лишние пустые строки между многострочными выражениями
func process(_ input: Int) {
  let value = max(
    input,
    0
  )


  print(
    value,
    value + 1
  )
}

/// Output
func process(_ input: Int) {
  let value = max(
    input,
    0
  )

  print(
    value,
    value + 1
  )
}

// MARK: - Do-catch соединяется с подготовкой по чтению внешнего значения в catch

func process(_ input: Int) {
  let error = input

  do {
    throw NSError(domain: "test", code: 0)
  } catch let failure {
    print(error, failure)
  }
}

/// Output

func process(_ input: Int) {
  let error = input
  do {
    throw NSError(domain: "test", code: 0)
  } catch let failure {
    print(error, failure)
  }
}

// MARK: - Лишние пустые строки между обычными действиями
func update(_ input: Int, first: inout [Int], second: inout [Int]) {
  let value = input
  first.append(value)


  second.removeAll()
  first.sort()
}

/// Output
func update(_ input: Int, first: inout [Int], second: inout [Int]) {
  let value = input
  first.append(value)

  second.removeAll()
  first.sort()
}

// MARK: - Связь с подготовленными значениями объединяет проверки
func declarationsThenChecksAndReturn() -> Int {
  let a = 1
  let b = 2

  if a == b { return a }

  if b > a {
    return b
  }

  return a
}

/// Output
func declarationsThenChecksAndReturn() -> Int {
  let a = 1
  let b = 2
  if a == b { return a }
  if b > a {
    return b
  }
  return a
}

// MARK: - Подготовка значений отделяется от серии вызовов
func process(_ input: Int, other: Int, consume: (Bool) -> Void) {
  let first = input
  let second = other
  consume(first > 0)
  consume(second > 0)
}

/// Output
func process(_ input: Int, other: Int, consume: (Bool) -> Void) {
  let first = input
  let second = other

  consume(first > 0)
  consume(second > 0)
}

// MARK: - Короткое объявление соединяется с многострочным вызовом, читающим значение
func process(_ input: Int) {
  let value = input

  print(
    value,
    value + 1
  )
}

/// Output
func process(_ input: Int) {
  let value = input
  print(
    value,
    value + 1
  )
}

// MARK: - Чтение только в ветках switch не объединяет группы
func label(_ kind: Int, center: Int) {
  let angle = center + 90
  switch kind {
  case 0:
    print("label", angle)

  default:
    print("circular", angle)
  }
}

/// Output
func label(_ kind: Int, center: Int) {
  let angle = center + 90

  switch kind {
  case 0:
    print("label", angle)

  default:
    print("circular", angle)
  }
}

// MARK: - Switch соединяется с объявлением переключаемого значения
func process(_ input: Int) {
  let value = input

  switch value {
  case 0: print("zero")
  default: print(value)
  }
}

/// Output
func process(_ input: Int) {
  let value = input
  switch value {
  case 0: print("zero")
  default: print(value)
  }
}

// MARK: - После объявления с четырьмя строками аргументов добавляется разрыв перед return

func value() -> String {
  let value = "a".replacingOccurrences(
    of: "a",
    with: "b",
    options: .literal,
    range: nil
  )
  return value
}

/// Output

func value() -> String {
  let value = "a".replacingOccurrences(
    of: "a",
    with: "b",
    options: .literal,
    range: nil
  )

  return value
}

// MARK: - Три обычных действия идут подряд
func update(_ first: inout [Int], second: inout [Int]) {
  first.removeAll()

  second.sort()

  first.append(0)
}

/// Output
func update(_ first: inout [Int], second: inout [Int]) {
  first.removeAll()
  second.sort()
  first.append(0)
}

// MARK: - Вызовы соединяются с объявлением читаемых элементов кортежа
func process(_ input: (Int, Int)) {
  let (first, second) = input

  print(first)
  print(second)
  print(first + second)
}

/// Output
func process(_ input: (Int, Int)) {
  let (first, second) = input
  print(first)
  print(second)
  print(first + second)
}

// MARK: - Слабый захват соединяет замыкание с объявлением объекта

enum Examples {

  static func process(_ input: NSObject) {
    let object = input

    let completion = { [weak object] in
      guard let object else { return }
      print(object)
    }
    completion()
  }
}

/// Output

enum Examples {

  static func process(_ input: NSObject) {
    let object = input
    let completion = { [weak object] in
      guard let object else { return }
      print(object)
    }
    completion()
  }
}

// MARK: - Лишний разрыв внутри серии проверок удаляется
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input
  let second = other

  XCTAssertGreaterThan(first, 0)

  XCTAssertGreaterThan(second, 0)
}

/// Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input
  let second = other

  XCTAssertGreaterThan(first, 0)
  XCTAssertGreaterThan(second, 0)
}

// MARK: - Лишний разрыв внутри серии вызовов удаляется
func run(input: Int, other: Int, consume: (Int, Int) -> Void) {
  let first = input
  let second = other

  consume(first, 0)

  consume(second, 0)
}

/// Output
func run(input: Int, other: Int, consume: (Int, Int) -> Void) {
  let first = input
  let second = other

  consume(first, 0)
  consume(second, 0)
}

// MARK: - Проверка другого значения отделяется от присваивания result
func run(input: Int) {
  var result = input
  let original = input
  result = input + 1
  XCTAssertEqual(original, input)
}

/// Output
func run(input: Int) {
  var result = input
  let original = input
  result = input + 1

  XCTAssertEqual(original, input)
}

// MARK: - Вызов с другим значением отделяется от присваивания result
func run(input: Int, consume: (Int, Int) -> Void) {
  var result = input
  let original = input
  result = input + 1
  consume(original, input)
}

/// Output
func run(input: Int, consume: (Int, Int) -> Void) {
  var result = input
  let original = input
  result = input + 1

  consume(original, input)
}

// MARK: - Проверка соединяется с подготовкой и отделяется от производного объявления
func run(input: Int, sink: (Int) -> Void) {
  let value = input

  XCTAssertEqual(value, input)
  let next = abs(value)
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void) {
  let value = input
  XCTAssertEqual(value, input)

  let next = abs(value)
  sink(next)
}

// MARK: - Вызов соединяется с подготовкой и отделяется от производного объявления
func run(input: Int, sink: (Int) -> Void, consume: (Int, Int) -> Void) {
  let value = input

  consume(value, input)
  let next = abs(value)
  sink(next)
}

/// Output
func run(input: Int, sink: (Int) -> Void, consume: (Int, Int) -> Void) {
  let value = input
  consume(value, input)

  let next = abs(value)
  sink(next)
}

// MARK: - Присваивание и связанная проверка образуют пару
func run(input: Int) {
  var result = input

  XCTAssertEqual(result, input)
  result = input + 1

  XCTAssertEqual(result, input + 1)
}

/// Output
func run(input: Int) {
  var result = input
  XCTAssertEqual(result, input)

  result = input + 1
  XCTAssertEqual(result, input + 1)
}

// MARK: - Присваивание и связанный вызов образуют пару
func run(input: Int, consume: (Int, Int) -> Void) {
  var result = input

  consume(result, input)
  result = input + 1

  consume(result, input + 1)
}

/// Output
func run(input: Int, consume: (Int, Int) -> Void) {
  var result = input
  consume(result, input)

  result = input + 1
  consume(result, input + 1)
}

// MARK: - Проверки результата составного присваивания соединяются с подготовкой

func run(input: Int) {
  var result = input
  result += 1

  XCTAssertGreaterThan(result, input)
  XCTAssertEqual(result, input + 1)
}

/// Output

func run(input: Int) {
  var result = input
  result += 1
  XCTAssertGreaterThan(result, input)
  XCTAssertEqual(result, input + 1)
}

// MARK: - Вызовы с результатом составного присваивания соединяются с подготовкой

func run(input: Int, consume: (Int, Int) -> Void) {
  var result = input
  result += 1

  consume(result, input)
  consume(result, input + 1)
}

/// Output

func run(input: Int, consume: (Int, Int) -> Void) {
  var result = input
  result += 1
  consume(result, input)
  consume(result, input + 1)
}

// MARK: - Объявление и связанный макрос expect образуют пару
func run(input: Int) {
  let first = input + 1

  #expect(first > input)
  let second = input + 2

  #expect(second > input)
}

/// Output
func run(input: Int) {
  let first = input + 1
  #expect(first > input)

  let second = input + 2
  #expect(second > input)
}

// MARK: - Независимое объявление и связанный вызов образуют пару
func run(input: Int, consume: (Bool) -> Void) {
  let first = input + 1

  consume(first > input)
  let second = input + 2

  consume(second > input)
}

/// Output
func run(input: Int, consume: (Bool) -> Void) {
  let first = input + 1
  consume(first > input)

  let second = input + 2
  consume(second > input)
}

// MARK: - Серия проверок с вызываемым замыканием отделяется от подготовки
func run(input: Int) {
  let result = input
  XCTAssertTrue({ result == input }())
  XCTAssertEqual(result, input)
  XCTAssertGreaterThanOrEqual(result, Int.min)
}

/// Output
func run(input: Int) {
  let result = input

  XCTAssertTrue({ result == input }())
  XCTAssertEqual(result, input)
  XCTAssertGreaterThanOrEqual(result, Int.min)
}

// MARK: - Серия обычных вызовов с вызываемым замыканием отделяется от подготовки
func run(input: Int, consume: (Bool) -> Void, compare: (Int, Int) -> Void) {
  let result = input
  consume({ result == input }())
  compare(result, input)
  compare(result, Int.min)
}

/// Output
func run(input: Int, consume: (Bool) -> Void, compare: (Int, Int) -> Void) {
  let result = input

  consume({ result == input }())
  compare(result, input)
  compare(result, Int.min)
}

// MARK: - Лишние пустые строки между многострочной подготовкой и проверками
enum LayoutTest {

  static func verify(_ pages: [[Int]]) {
    let layout = pages
      .flatMap { $0 }
      .prefix(
        2
      )


    XCTAssertEqual(layout.count, 2)
    XCTAssertEqual(layout.first, 1)
    XCTAssertEqual(layout.last, 2)
  }
}

/// Output
enum LayoutTest {

  static func verify(_ pages: [[Int]]) {
    let layout = pages
      .flatMap { $0 }
      .prefix(
        2
      )

    XCTAssertEqual(layout.count, 2)
    XCTAssertEqual(layout.first, 1)
    XCTAssertEqual(layout.last, 2)
  }
}

// MARK: - Лишние пустые строки между многострочной подготовкой и вызовами
enum LayoutTest {

  static func verify(_ pages: [[Int]], consume: (Int?, Int?) -> Void) {
    let layout = pages
      .flatMap { $0 }
      .prefix(
        2
      )


    consume(layout.count, 2)
    consume(layout.first, 1)
    consume(layout.last, 2)
  }
}

/// Output
enum LayoutTest {

  static func verify(_ pages: [[Int]], consume: (Int?, Int?) -> Void) {
    let layout = pages
      .flatMap { $0 }
      .prefix(
        2
      )

    consume(layout.count, 2)
    consume(layout.first, 1)
    consume(layout.last, 2)
  }
}

// MARK: - Подготовка значений отделяется от серии expect
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input
  let second = other
  #expect(first > 0)
  #expect(second > 0)
}

/// Output
func run(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input
  let second = other

  #expect(first > 0)
  #expect(second > 0)
}
