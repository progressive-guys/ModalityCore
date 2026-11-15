// MARK: - Сортировка свойств с конкретной обёрткой оставлена для ручного решения
@propertyWrapper
struct Wrapped {
  var wrappedValue: Int
}

struct Example {
  @Wrapped var longerName: Int = 1
  @Wrapped var x: Int = 2
}

func makeExample() -> Example { Example(longerName: 3, x: 4) }

// MARK: - Сортировка свойств с обобщённой обёрткой оставлена для ручного решения
@propertyWrapper
struct Box<T> {
  var wrappedValue: T
}

struct GenericExample {
  @Box var longerName: Int
  @Box var x: Int
}

func makeExample() -> GenericExample { GenericExample(longerName: 3, x: 4) }

// MARK: - Сортировка свойств, определяющих аргументы поэлементного инициализатора, оставлена для ручного решения
struct Pair {
  let longerName: Int
  let x: Int
}

func makePair() -> Pair {
  Pair(longerName: 1, x: 2)
}

// MARK: - Сортировка свойств с побочными эффектами инициализации оставлена для ручного решения
private func trace(_ value: Int) -> Int {
  print(value)
  return value
}

private final class Values {
  let longerName = trace(1)
  let x = trace(2)
}

// MARK: - Сортировка свойств с побочными эффектами обёртки не выполняется автоматически
@propertyWrapper
struct Recorded<Value> {
  var wrappedValue: Value

  init(wrappedValue: Value) {
    print("initializing", wrappedValue)
    self.wrappedValue = wrappedValue
  }
}

final class Values {
  @Recorded var longerName = 1
  @Recorded var x = 2
}
