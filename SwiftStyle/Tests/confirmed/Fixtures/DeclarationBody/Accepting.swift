// MARK: - Короткие реализации свойств и методов остаются многострочными
struct Example {

  var value: Int {
    1
  }

  func read() -> Int {
    value
  }

  static func empty() { }
}

// MARK: - Пустые тела функций, методов и аксессоров допустимы на одной строке
func empty() { }

final class Empty {

  init() { }
  deinit { }

  var value: Int {
    get { 0 }
    set { }
  }

  func run() { }
}

// MARK: - Требования протокола сохраняют запись без тела реализации
protocol Example {

  init()

  subscript(index: Int) -> Int { get }

  var value: Int { get set }

  func read() -> Int
}

// MARK: - Короткие get и set остаются на отдельных строках
struct Accessors {

  var value: Int {
    get { 0 }
    set { _ = newValue }
  }
}

// MARK: - Короткие willSet и didSet остаются на отдельных строках
struct Observed {

  var value = 0 {
    willSet { _ = newValue }
    didSet { _ = oldValue }
  }
}

// MARK: - Реализации в ветках условной компиляции допустимы на одной строке
struct Conditional {

  #if DEBUG
  var value: Int { 1 }
  func read() -> Int { value }

  #elseif TEST_BUILD
  var value: Int { 2 }
  func read() -> Int { value }

  #else
  var value: Int { 0 }
  func read() -> Int { value }
  #endif
}

// MARK: - Вне условной компиляции непустой метод остаётся многострочным
struct Mixed {

  #if DEBUG
  func debugValue() -> Int { 1 }
  #endif

  func read() -> Int {
    0
  }
}
