// MARK: - Связи локальных функций, замыканий и вычисляемых свойств (1)
func localFunction(input: Int, sink: (Int) -> Void) {
  let value = sink
  value(input)

  let next = value
  next(input)
}

func closureArgument(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
  let value = input
  visit { value }
  let next = value + 1
  sink(next)
}

func closureInitializer(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = { value + 1 }
  sink(next())
}

/// Output
func localFunction(input: Int, sink: (Int) -> Void) {
  let value = sink
  value(input)
  let next = value
  next(input)
}

func closureArgument(input: Int, visit: (() -> Int) -> Void, sink: (Int) -> Void) {
  let value = input
  visit { value }

  let next = value + 1
  sink(next)
}

func closureInitializer(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = { value + 1 }
  sink(next())
}

// MARK: - Пустая строка перед локальным вычисляемым свойством удаляется
func computedValue(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  var next: Int { value + 1 }
  sink(next)
}

/// Output
func computedValue(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  var next: Int {
    value + 1
  }
  sink(next)
}

// MARK: - Guard и if отделяются от предыдущих объявлений и вызовов
enum Example {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    guard value > 0 else { return }
    sink(value)
  }

  static func runIf(input: Int, sink: (Int) -> Void) {
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

    guard value > 0 else { return }
    sink(value)
  }

  static func runIf(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)

    if value > 0 {
      sink(value)
    }

    sink(input)
  }
}

// MARK: - Связи производных объявлений с аргументами и предыдущими вызовами (1)
func conditionalInitializer(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = if input > 0 {
    value
  } else {
    0
  }
  sink(next)
}

func independentExpression(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = input + 1
  sink(next)
}

/// Output
func conditionalInitializer(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = if input > 0 {
    value
  } else {
    0
  }

  sink(next)
}

func independentExpression(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = input + 1
  sink(next)
}

// MARK: - Связи производных объявлений с аргументами и предыдущими вызовами (2)
func joinedValues(input: Int, sink: (Int) -> Void) {
  let first = input
  sink(first)

  let second = input + 1
  sink(second)
  let next = second + first
  sink(next)
}

func touch(_ value: inout Int) { value += 1 }

func inoutCall(input: Int, sink: (Int) -> Void) {
  var value = input
  touch(&value)

  let next = value + 1
  sink(next)
}

/// Output
func joinedValues(input: Int, sink: (Int) -> Void) {
  let first = input
  sink(first)

  let second = input + 1
  sink(second)

  let next = second + first
  sink(next)
}

func touch(_ value: inout Int) {
  value += 1
}

func inoutCall(input: Int, sink: (Int) -> Void) {
  var value = input
  touch(&value)
  let next = value + 1
  sink(next)
}

// MARK: - Связи производных объявлений с аргументами и предыдущими вызовами (3)
struct Box {
  let value: Int }

func log(_ path: KeyPath<Box, Int>, _ value: Int) { }

func keyPathArgument(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(\Box.value, other)

  let next = value + 1
  sink(next)
}

func log(value: Int) { }

func argumentLabel(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(value: other)

  let next = value + 1
  sink(next)
}

/// Output
struct Box {
  let value: Int }

func log(_ path: KeyPath<Box, Int>, _ value: Int) { }

func keyPathArgument(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(\Box.value, other)
  let next = value + 1
  sink(next)
}

func log(value: Int) { }

func argumentLabel(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  log(value: other)
  let next = value + 1
  sink(next)
}

// MARK: - Связи производных объявлений с аргументами и предыдущими вызовами (4)
struct Box {
  let value: Int }

func commentBoundary(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  // Next calculation.
  let next = abs(value)
  sink(next)
}

func pair(_ a: Int, _ b: Int) { }

func otherReceiver(input: Int, box: Box, sink: (Int) -> Void) {
  let value = input
  let other = input
  pair(box.value, other)

  let next = value + 1
  sink(next)
}

/// Output
struct Box {
  let value: Int }

func commentBoundary(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  // Next calculation.
  let next = abs(value)
  sink(next)
}

func pair(_ a: Int, _ b: Int) { }

func otherReceiver(input: Int, box: Box, sink: (Int) -> Void) {
  let value = input
  let other = input
  pair(box.value, other)
  let next = value + 1
  sink(next)
}

// MARK: - Связи производных объявлений с аргументами и предыдущими вызовами (5)
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

func multilineCall(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(
    value
  )

  let next = value + 1
  sink(next)
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

func multilineCall(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(
    value
  )
  let next = value + 1
  sink(next)
}

// MARK: - Связи производных объявлений с аргументами и предыдущими вызовами (6)
func multipleBindings(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = value, ignored = input
  sink(next + ignored)
}

func aliasedValue(input: Int, sink: (Int) -> Void) {
  let value = input
  let alias = value
  sink(alias)

  let next = abs(value)
  sink(next)
}

func extraGap(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)


  let next = value + 1
  sink(next)
}

/// Output
func multipleBindings(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = value, ignored = input
  sink(next + ignored)
}

func aliasedValue(input: Int, sink: (Int) -> Void) {
  let value = input
  let alias = value
  sink(alias)
  let next = abs(value)
  sink(next)
}

func extraGap(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = value + 1
  sink(next)
}

// MARK: - Связи производных объявлений с аргументами и предыдущими вызовами (7)
func earlierCall(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input + 1
  sink(value)
  sink(other)

  let next = value + 1
  sink(next)
}

func mutatedReceiver(input: Int, sink: (Int) -> Void) {
  var value: [Int] = []
  value.append(input)

  let next = value.count
  sink(next)
}

func returnedValue(input: Int, sink: (Int) -> Void) -> Int {
  let value = input
  let copy = value + 1
  sink(copy)

  return abs(copy)
}

/// Output
func earlierCall(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input + 1
  sink(value)
  sink(other)
  let next = value + 1
  sink(next)
}

func mutatedReceiver(input: Int, sink: (Int) -> Void) {
  var value: [Int] = []
  value.append(input)
  let next = value.count
  sink(next)
}

func returnedValue(input: Int, sink: (Int) -> Void) -> Int {
  let value = input
  let copy = value + 1
  sink(copy)
  return abs(copy)
}

// MARK: - Связи производных объявлений с аргументами и предыдущими вызовами (8)
func shadowedArgument(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  sink([other].map { value in value }.count)

  let next = value + 1
  sink(next)
}

func shortBody(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let next = abs(value)
}

func tupleBinding(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)

  let (next, _) = (value, input)
  sink(next)
}

/// Output
func shadowedArgument(input: Int, sink: (Int) -> Void) {
  let value = input
  let other = input
  sink([other].map { value in value }.count)
  let next = value + 1
  sink(next)
}

func shortBody(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let next = abs(value)
}

func tupleBinding(input: Int, sink: (Int) -> Void) {
  let value = input
  sink(value)
  let (next, _) = (value, input)
  sink(next)
}
