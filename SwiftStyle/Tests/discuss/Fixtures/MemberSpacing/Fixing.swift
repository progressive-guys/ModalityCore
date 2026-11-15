// MARK: - Пустые строки между однострочными псевдонимами типов удаляются
enum Instrument {
  typealias Fret = Int

  typealias String = Int

  typealias Tuning = [Int]
}

/// Output
enum Instrument {

  typealias Fret = Int
  typealias String = Int
  typealias Tuning = [Int]
}

// MARK: - Интервалы после многострочной функции и между однострочными функциями
struct Methods {

  func a() -> Int {
    1
  }
  func b() -> Int { 2 }
  func first() -> Int { 1 }

  func second() -> Int { 2 }
}

/// Output
struct Methods {

  func a() -> Int {
    1
  }

  func b() -> Int { 2 }
  func first() -> Int { 1 }
  func second() -> Int { 2 }
}

// MARK: - Многострочный getter отделяется от следующего метода
struct GetterBeforeMethod {

  var x: Int {
    1
  }
  func read() -> Int { x }
}

/// Output
struct GetterBeforeMethod {

  var x: Int {
    1
  }

  func read() -> Int { x }
}

// MARK: - Интервалы между однострочными и многострочными требованиями методов
protocol Worker {

  func start()

  func stop()

  func first(
    value: Int
  )
  func second()
}

/// Output
protocol Worker {

  func start()
  func stop()

  func first(
    value: Int
  )

  func second()
}

// MARK: - Вложенный тип отделяется от следующего свойства
struct Value {

  enum Key {
    case value
  }
  let value: Int
}

/// Output
struct Value {

  enum Key {
    case value
  }

  let value: Int
}
