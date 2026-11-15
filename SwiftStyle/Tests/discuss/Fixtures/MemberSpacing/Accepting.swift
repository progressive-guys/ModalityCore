// MARK: - Пустая строка перед многострочной функцией
struct Methods {

  func a() -> Int { 1 }
  func b() -> Int { 2 }

  func c() -> Int {
    3
  }
}

// MARK: - Разделение разных видов членов типа
struct DifferentKinds {

  var a = 1

  init() {}

  func read() -> Int { a }
}

// MARK: - Между однострочными вложенными типами сохраняется пустая строка
struct SeparatedTypes {

  struct First {}

  struct Second {}
}

// MARK: - Многострочный псевдоним типа
typealias Name = String

typealias Entry = (
  Name,
  Int
)

typealias Entries = [Entry]

// MARK: - Группы требований протокола по виду объявления
protocol Worker {

  associatedtype Value

  init()

  subscript(index: Int) -> Value { get }

  var current: Value { get }

  func start()
}
