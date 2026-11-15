// MARK: - Последовательные присваивания образуют одну группу
func configure(_ state: inout (displayLink: Int, callbackTarget: Int, isRunning: Bool, lastError: String?)) {
  state.displayLink = 1
  state.callbackTarget = 2

  state.isRunning = true
  state.lastError = nil
}

func configure(_ left: inout [Int], right: inout [Int]) {
  var first = [0]
  first.append(1)

  var second = [0]
  second.append(2)

  left = first

  right = first + second
}

/// Output
func configure(_ state: inout (displayLink: Int, callbackTarget: Int, isRunning: Bool, lastError: String?)) {
  state.displayLink = 1
  state.callbackTarget = 2
  state.isRunning = true
  state.lastError = nil
}

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

  func apply(_ value: Int) { }
  func render() { }
  func touch() { }
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

  func apply(_ value: Int) { }
  func render() { }
  func touch() { }
}

func run(node: Node) {
  node.touch()
  node.render()

  node.first = 1
  node.second = 2
}

// MARK: - Объявления соединяются со связанными действиями и захватами (1)
func explicitCapture(_ input: Int) {
  let value = input

  let completion = { [captured = value] in
    print(captured)
  }
  completion()
}

func closureRead(_ values: [Int], identifier: Int) {
  let requestID = identifier

  values.forEach { value in
    print(requestID, value)
  }
}

/// Output
func explicitCapture(_ input: Int) {
  let value = input
  let completion = { [captured = value] in
    print(captured)
  }
  completion()
}

func closureRead(_ values: [Int], identifier: Int) {
  let requestID = identifier
  values.forEach { value in
    print(requestID, value)
  }
}

// MARK: - Объявления соединяются со связанными действиями и захватами (2)
func switchCapture(_ kind: Int, center: Int) {
  let angle = center + 90

  let completion = {
    switch kind {
    case 0: print("label", angle)
    default: print("circular", angle)
    }
  }
  completion()
}

func closureArgument(_ values: [Int]) {
  let completion: (Int) -> Void = { value in
    print(value)
  }

  values.forEach(completion)
}

func calledClosure(input: Int, other: Int, sink: @escaping (Int) -> Void) {
  let callback: () -> Void = {
    sink(input)
  }
  callback()
}

/// Output
func switchCapture(_ kind: Int, center: Int) {
  let angle = center + 90
  let completion = {
    switch kind {
    case 0: print("label", angle)
    default: print("circular", angle)
    }
  }
  completion()
}

func closureArgument(_ values: [Int]) {
  let completion: (Int) -> Void = { value in
    print(value)
  }
  values.forEach(completion)
}

func calledClosure(input: Int, other: Int, sink: @escaping (Int) -> Void) {
  let callback: () -> Void = {
    sink(input)
  }

  callback()
}

// MARK: - Объявления соединяются со связанными действиями и захватами (3)
func headers(_ extra: [String]) -> [String] {
  var fields = ["default"]

  if !extra.isEmpty {
    fields.append(contentsOf: extra)
  }
  return fields
}

func elseRead(_ input: Int?, alternative: Int?) {
  let value = input

  if let value = alternative {
    print(value)
  } else {
    print(value as Any)
  }
}

func patternRead(_ input: Int, candidate: Int) {
  let value = input

  if case value = candidate {
    print("matched")
  }
}

/// Output
func headers(_ extra: [String]) -> [String] {
  var fields = ["default"]
  if !extra.isEmpty {
    fields.append(contentsOf: extra)
  }
  return fields
}

func elseRead(_ input: Int?, alternative: Int?) {
  let value = input
  if let value = alternative {
    print(value)
  } else {
    print(value as Any)
  }
}

func patternRead(_ input: Int, candidate: Int) {
  let value = input
  if case value = candidate {
    print("matched")
  }
}

// MARK: - Объявления соединяются со связанными действиями и захватами (4)
func guardBinding(_ input: Int?) {
  let candidate = input

  guard let value = candidate else { return }
  print(value)
  print(value + 1)
}

func guardFailureRead(_ input: Int, enabled: Bool) {
  let value = input

  guard enabled else {
    print(value)
    return
  }
  print(value)
}

func play(_ input: Int, high: Bool) {
  let volume = input

  if high {
    print(volume)
  } else {
    print(-volume)
  }
}

/// Output
func guardBinding(_ input: Int?) {
  let candidate = input
  guard let value = candidate else { return }
  print(value)
  print(value + 1)
}

func guardFailureRead(_ input: Int, enabled: Bool) {
  let value = input
  guard enabled else {
    print(value)
    return
  }

  print(value)
}

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

// MARK: - Границы групп в проверках, циклах и вычислениях (1)
func missingGapBeforeReturn(_ x: Int) -> Int {
  if x == 0 { return 0 }
  if x < 0 { return -1 }
  if x == 1 { return 1 }
  return x
}

func loopRead(_ input: [Int]) {
  let values = input

  for value in values {
    print(value)
  }
}

func check(_ value: Int) {
  guard value > 0 else { return }
  if value == 1 {
    return
  }
  guard value < 10 else { return }
}

/// Output
func missingGapBeforeReturn(_ x: Int) -> Int {
  if x == 0 { return 0 }
  if x < 0 { return -1 }
  if x == 1 { return 1 }

  return x
}

func loopRead(_ input: [Int]) {
  let values = input
  for value in values {
    print(value)
  }
}

func check(_ value: Int) {
  guard value > 0 else { return }

  if value == 1 {
    return
  }

  guard value < 10 else { return }
}

// MARK: - Границы групп в проверках, циклах и вычислениях (2)
func multilineActions(_ input: Int) {
  let value = max(
    input,
    0
  )


  print(
    value,
    value + 1
  )
}

func catchRead(_ input: Int) {
  let error = input

  do {
    throw NSError(domain: "test", code: 0)
  } catch let failure {
    print(error, failure)
  }
}

/// Output
func multilineActions(_ input: Int) {
  let value = max(
    input,
    0
  )

  print(
    value,
    value + 1
  )
}

func catchRead(_ input: Int) {
  let error = input
  do {
    throw NSError(domain: "test", code: 0)
  } catch let failure {
    print(error, failure)
  }
}

// MARK: - Границы групп в проверках, циклах и вычислениях (3)
func differentReceivers(_ input: Int, first: inout [Int], second: inout [Int]) {
  let value = input
  first.append(value)


  second.removeAll()
  first.sort()
}

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
func differentReceivers(_ input: Int, first: inout [Int], second: inout [Int]) {
  let value = input
  first.append(value)

  second.removeAll()
  first.sort()
}

func declarationsThenChecksAndReturn() -> Int {
  let a = 1
  let b = 2
  if a == b { return a }
  if b > a {
    return b
  }
  return a
}

// MARK: - Границы групп в проверках, циклах и вычислениях (4)
func preparedCall(_ input: Int, other: Int, consume: (Bool) -> Void) {
  let first = input
  let second = other
  consume(first > 0)
  consume(second > 0)
}

func multilineCall(_ input: Int) {
  let value = input

  print(
    value,
    value + 1
  )
}

func switchBranchRead(_ kind: Int, center: Int) {
  let angle = center + 90
  switch kind {
  case 0:
    print("label", angle)

  default:
    print("circular", angle)
  }
}

/// Output
func preparedCall(_ input: Int, other: Int, consume: (Bool) -> Void) {
  let first = input
  let second = other

  consume(first > 0)
  consume(second > 0)
}

func multilineCall(_ input: Int) {
  let value = input
  print(
    value,
    value + 1
  )
}

func switchBranchRead(_ kind: Int, center: Int) {
  let angle = center + 90

  switch kind {
  case 0:
    print("label", angle)

  default:
    print("circular", angle)
  }
}

// MARK: - Границы групп в проверках, циклах и вычислениях (5)
func switchSubject(_ input: Int) {
  let value = input

  switch value {
  case 0: print("zero")
  default: print(value)
  }
}

func value() -> String {
  let value = "a".replacingOccurrences(
    of: "a",
    with: "b",
    options: .literal,
    range: nil
  )
  return value
}

func shortBody(_ first: inout [Int], second: inout [Int]) {
  first.removeAll()

  second.sort()

  first.append(0)
}

/// Output
func switchSubject(_ input: Int) {
  let value = input
  switch value {
  case 0: print("zero")
  default: print(value)
  }
}

func value() -> String {
  let value = "a".replacingOccurrences(
    of: "a",
    with: "b",
    options: .literal,
    range: nil
  )

  return value
}

func shortBody(_ first: inout [Int], second: inout [Int]) {
  first.removeAll()
  second.sort()
  first.append(0)
}

// MARK: - Вызовы соединяются с объявлением читаемых элементов кортежа
func tupleRead(_ input: (Int, Int)) {
  let (first, second) = input

  print(first)
  print(second)
  print(first + second)
}

/// Output
func tupleRead(_ input: (Int, Int)) {
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

// MARK: - Группировка проверок, вызовов и присваиваний по используемым значениям (1)
func checkSeries(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input
  let second = other

  XCTAssertGreaterThan(first, 0)

  XCTAssertGreaterThan(second, 0)
}

func callSeries(input: Int, other: Int, consume: (Int, Int) -> Void) {
  let first = input
  let second = other

  consume(first, 0)

  consume(second, 0)
}

func unrelatedCheck(input: Int) {
  var result = input
  let original = input
  result = input + 1
  XCTAssertEqual(original, input)
}

/// Output
func checkSeries(input: Int, other: Int, sink: (Int) -> Void) {
  let first = input
  let second = other

  XCTAssertGreaterThan(first, 0)
  XCTAssertGreaterThan(second, 0)
}

func callSeries(input: Int, other: Int, consume: (Int, Int) -> Void) {
  let first = input
  let second = other

  consume(first, 0)
  consume(second, 0)
}

func unrelatedCheck(input: Int) {
  var result = input
  let original = input
  result = input + 1

  XCTAssertEqual(original, input)
}

// MARK: - Группировка проверок, вызовов и присваиваний по используемым значениям (2)
func unrelatedCall(input: Int, consume: (Int, Int) -> Void) {
  var result = input
  let original = input
  result = input + 1
  consume(original, input)
}

func relatedCheck(input: Int, sink: (Int) -> Void) {
  let value = input

  XCTAssertEqual(value, input)
  let next = abs(value)
  sink(next)
}

func relatedCall(input: Int, sink: (Int) -> Void, consume: (Int, Int) -> Void) {
  let value = input

  consume(value, input)
  let next = abs(value)
  sink(next)
}

/// Output
func unrelatedCall(input: Int, consume: (Int, Int) -> Void) {
  var result = input
  let original = input
  result = input + 1

  consume(original, input)
}

func relatedCheck(input: Int, sink: (Int) -> Void) {
  let value = input
  XCTAssertEqual(value, input)

  let next = abs(value)
  sink(next)
}

func relatedCall(input: Int, sink: (Int) -> Void, consume: (Int, Int) -> Void) {
  let value = input
  consume(value, input)

  let next = abs(value)
  sink(next)
}

// MARK: - Группировка проверок, вызовов и присваиваний по используемым значениям (3)
func assignmentCheck(input: Int) {
  var result = input

  XCTAssertEqual(result, input)
  result = input + 1

  XCTAssertEqual(result, input + 1)
}

func assignmentCall(input: Int, consume: (Int, Int) -> Void) {
  var result = input

  consume(result, input)
  result = input + 1

  consume(result, input + 1)
}

func compoundCheck(input: Int) {
  var result = input
  result += 1

  XCTAssertGreaterThan(result, input)
  XCTAssertEqual(result, input + 1)
}

/// Output
func assignmentCheck(input: Int) {
  var result = input
  XCTAssertEqual(result, input)

  result = input + 1
  XCTAssertEqual(result, input + 1)
}

func assignmentCall(input: Int, consume: (Int, Int) -> Void) {
  var result = input
  consume(result, input)

  result = input + 1
  consume(result, input + 1)
}

func compoundCheck(input: Int) {
  var result = input
  result += 1
  XCTAssertGreaterThan(result, input)
  XCTAssertEqual(result, input + 1)
}

// MARK: - Группировка проверок, вызовов и присваиваний по используемым значениям (4)
func compoundCall(input: Int, consume: (Int, Int) -> Void) {
  var result = input
  result += 1

  consume(result, input)
  consume(result, input + 1)
}

func expectRead(input: Int) {
  let first = input + 1

  #expect(first > input)
  let second = input + 2

  #expect(second > input)
}

func independentRead(input: Int, consume: (Bool) -> Void) {
  let first = input + 1

  consume(first > input)
  let second = input + 2

  consume(second > input)
}

/// Output
func compoundCall(input: Int, consume: (Int, Int) -> Void) {
  var result = input
  result += 1
  consume(result, input)
  consume(result, input + 1)
}

func expectRead(input: Int) {
  let first = input + 1
  #expect(first > input)

  let second = input + 2
  #expect(second > input)
}

func independentRead(input: Int, consume: (Bool) -> Void) {
  let first = input + 1
  consume(first > input)

  let second = input + 2
  consume(second > input)
}

// MARK: - Группировка проверок, вызовов и присваиваний по используемым значениям (5)
func closureCheck(input: Int) {
  let result = input
  XCTAssertTrue({ result == input }())
  XCTAssertEqual(result, input)
  XCTAssertGreaterThanOrEqual(result, Int.min)
}

func closureCall(input: Int, consume: (Bool) -> Void, compare: (Int, Int) -> Void) {
  let result = input
  consume({ result == input }())
  compare(result, input)
  compare(result, Int.min)
}

/// Output
func closureCheck(input: Int) {
  let result = input

  XCTAssertTrue({ result == input }())
  XCTAssertEqual(result, input)
  XCTAssertGreaterThanOrEqual(result, Int.min)
}

func closureCall(input: Int, consume: (Bool) -> Void, compare: (Int, Int) -> Void) {
  let result = input

  consume({ result == input }())
  compare(result, input)
  compare(result, Int.min)
}

// MARK: - Лишние пустые строки после подготовки перед проверками и вызовами
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
