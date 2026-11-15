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

// MARK: - Пустая строка после многострочной функции
struct MultilineMethod {

  func a() -> Int {
    1
  }
  func b() -> Int { 2 }
}

/// Output
struct MultilineMethod {

  func a() -> Int {
    1
  }

  func b() -> Int { 2 }
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

// MARK: - Пустая строка между однострочными функциями удаляется
struct Methods {
  func first() -> Int { 1 }

  func second() -> Int { 2 }
}

/// Output
struct Methods {

  func first() -> Int { 1 }
  func second() -> Int { 2 }
}

// MARK: - Пустая строка между однострочными требованиями методов удаляется
protocol Worker {
  func start()

  func stop()
}

/// Output
protocol Worker {

  func start()
  func stop()
}

// MARK: - Многострочное требование метода отделяется от следующего
protocol Worker {

  func first(
    value: Int
  )
  func second()
}

/// Output
protocol Worker {

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
