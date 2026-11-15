// MARK: - Функции и локальные функции имеют многострочные тела
func value() -> Int { 1 }

func nestedValue() -> Int {
  func local() -> Int { 2 }
  return local()
}

/// Output
func value() -> Int {
  1
}

func nestedValue() -> Int {
  func local() -> Int {
    2
  }
  
  return local()
}

// MARK: - Методы экземпляра и типа имеют многострочные тела
struct Example {
  func read() -> Int { 1 }
  static func read() -> Int { 2 }
}

/// Output
struct Example {

  func read() -> Int {
    1
  }

  static func read() -> Int {
    2
  }
}

// MARK: - Вычисляемые свойства имеют многострочные тела
struct Example {
  var value: Int { 1 }
  static var shared: Int { 2 }
}

/// Output
struct Example {

  var value: Int {
    1
  }

  static var shared: Int {
    2
  }
}

// MARK: - Свойство и индексатор разворачиваются, короткие get и set остаются в строку
struct Example {
  private var stored = 0
  var value: Int { get { stored } set { stored = newValue } }
  subscript(index: Int) -> Int { index }
}

/// Output
struct Example {

  private var stored = 0

  var value: Int {
    get { stored }
    set { stored = newValue }
  }

  subscript(index: Int) -> Int {
    index
  }
}

// MARK: - Тело свойства переносится, короткие willSet и didSet сохраняются
struct Observed {
  var value = 0 { willSet { _ = newValue } didSet { _ = oldValue } }
}

/// Output
struct Observed {

  var value = 0 {
    willSet { _ = newValue }
    didSet { _ = oldValue }
  }
}

// MARK: - Непустые тела инициализатора и деинициализатора переносятся
final class Example {
  init() { print("created") }
  deinit { print("released") }
}

/// Output
final class Example {

  init() {
    print("created")
  }

  deinit {
    print("released")
  }
}

// MARK: - Метод вне условной компиляции разворачивается, метод внутри сохраняется
struct Mixed {
  #if DEBUG
  func debugValue() -> Int { 1 }
  #endif
  func read() -> Int { 0 }
}

/// Output
struct Mixed {

  #if DEBUG
  func debugValue() -> Int {
    1
  }
  #endif

  func read() -> Int {
    0
  }
}
