// MARK: - Разделение групп с функциями и замыканиями
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

// MARK: - Локальное вычисляемое свойство отделяется от соседних вызовов
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

// MARK: - Guard и if отделяются от предыдущего вызова
enum ChecksAfterCalls {

  static func run(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    guard value > 0 else { return }
    sink(value)
  }

  static func runIf(input: Int, sink: (Int) -> Void) {
    let value = input
    sink(value)
    if value > 0 { sink(value) }

    sink(input)
  }
}

/// Output
enum ChecksAfterCalls {

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

// MARK: - Условный инициализатор и независимые вызовы начинают новые группы
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

func independentExpression(input: Int, firstSink: (Int) -> Void, secondSink: (Int) -> Void) {
  let value = input
  firstSink(value)
  let next = input + 1
  secondSink(next)
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

func independentExpression(input: Int, firstSink: (Int) -> Void, secondSink: (Int) -> Void) {
  let value = input
  firstSink(value)

  let next = input + 1
  secondSink(next)
}
