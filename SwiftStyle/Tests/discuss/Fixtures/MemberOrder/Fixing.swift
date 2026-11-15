// MARK: - Порядок псевдонима, связанного типа и требований протокола
protocol Requirements {
  func read()
  var value: Int { get }
  subscript(index: Int) -> Int { get }
  associatedtype Value
  typealias Number = Int
  init()
}

/// Output
protocol Requirements {

  typealias Number = Int

  associatedtype Value

  init()

  subscript(index: Int) -> Int { get }

  var value: Int { get }

  func read()
}

// MARK: - Псевдоним и вложенный тип перед свойством и функцией
struct Values {
  var stored = 0
  typealias Value = Int
  func read() { }
  struct Nested { }
}

/// Output
struct Values {

  typealias Value = Int

  struct Nested { }

  var stored = 0

  func read() { }
}

// MARK: - Инициализатор, индексатор, вычисляемое свойство и функция
struct Values {
  func read() -> Int { value }
  var value: Int { 1 }
  subscript(index: Int) -> Int { index }
  init() { }
}

/// Output
struct Values {

  init() { }

  subscript(index: Int) -> Int {
    index
  }

  var value: Int {
    1
  }

  func read() -> Int {
    value
  }
}

// MARK: - Порядок инициализатора, деинициализатора и индексатора
final class Values {
  subscript(index: Int) -> Int { index }
  deinit { }
  init() { }
}

/// Output
final class Values {

  init() { }

  deinit { }

  subscript(index: Int) -> Int {
    index
  }
}

// MARK: - Комментарий перемещается вместе с вычисляемым свойством
struct Values {

  func read() -> Int { value }
  // Display value.
  var value: Int { 1 }
}

/// Output
struct Values {

  // Display value.
  var value: Int {
    1
  }

  func read() -> Int {
    value
  }
}

// MARK: - Вложенный тип перемещается перед функцией в расширении
struct Value { }

extension Value {
  func read() { }
  struct Nested { }
}

/// Output
struct Value { }

extension Value {

  struct Nested { }

  func read() { }
}

// MARK: - Хранимые свойства с наблюдателем и без него перед инициализатором
struct Values {
  init() { }
  var value = 0 { didSet { } }
  var stored = 1
}

/// Output
struct Values {

  var value = 0 { didSet { } }
  var stored = 1

  init() { }
}
