// MARK: - Псевдоним типа перед связанным типом
protocol Requirements {
  associatedtype Value
  typealias Number = Int
}

/// Output
protocol Requirements {

  typealias Number = Int

  associatedtype Value
}

// MARK: - Псевдоним типа перед хранимыми свойствами
struct AliasAfterStorage {
  var value = 0
  typealias Value = Int
}

/// Output
struct AliasAfterStorage {

  typealias Value = Int

  var value = 0
}

// MARK: - Связанный тип перед индексатором
protocol Requirements {
  subscript(index: Int) -> Int { get }
  associatedtype Value
}

/// Output
protocol Requirements {

  associatedtype Value

  subscript(index: Int) -> Int { get }
}

// MARK: - Вычисляемое свойство перед функцией
struct FunctionBeforeComputed {
  func read() -> Int { value }
  var value: Int { 1 }
}

/// Output
struct FunctionBeforeComputed {

  var value: Int { 1 }

  func read() -> Int { value }
}

// MARK: - Деинициализатор перед индексатором
final class SubscriptBeforeDeinit {
  subscript(index: Int) -> Int { index }
  deinit {}
}

/// Output
final class SubscriptBeforeDeinit {

  deinit {}

  subscript(index: Int) -> Int { index }
}

// MARK: - Инициализатор перед вычисляемым свойством
struct ComputedBeforeInitializer {
  var value: Int { 1 }
  init() {}
}

/// Output
struct ComputedBeforeInitializer {

  init() {}

  var value: Int { 1 }
}

// MARK: - Инициализатор перед деинициализатором
final class DeinitBeforeInit {
  deinit {}
  init() {}
}

/// Output
final class DeinitBeforeInit {

  init() {}

  deinit {}
}

// MARK: - Требование инициализатора перед требованием индексатора
protocol Values {
  subscript(index: Int) -> Int { get }
  init()
}

/// Output
protocol Values {

  init()

  subscript(index: Int) -> Int { get }
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
  var value: Int { 1 }

  func read() -> Int { value }
}

// MARK: - Вложенный тип перед функцией
struct TypeAfterFunction {
  func read() {}
  struct Value {}
}

/// Output
struct TypeAfterFunction {

  struct Value {}

  func read() {}
}

// MARK: - Вложенный тип перед хранимыми свойствами
struct Values {
  var stored = 0
  struct Nested {}
}

/// Output
struct Values {

  struct Nested {}

  var stored = 0
}

// MARK: - Вложенный тип перемещается перед функцией в расширении
struct Value {}

extension Value {
  func read() {}
  struct Nested {}
}

/// Output
struct Value {}

extension Value {

  struct Nested {}

  func read() {}
}

// MARK: - Свойство с наблюдателями перед инициализатором
struct ObserverIsStored {
  init() {}
  var value = 0 { didSet {} }
}

/// Output
struct ObserverIsStored {

  var value = 0 { didSet {} }

  init() {}
}

// MARK: - Требование свойства перед требованием метода
protocol Values {
  func read()
  var value: Int { get }
}

/// Output
protocol Values {

  var value: Int { get }

  func read()
}

// MARK: - Хранимое свойство перед инициализатором
struct InitializerBeforeStorage {
  init() {}
  var value = 1
}

/// Output
struct InitializerBeforeStorage {

  var value = 1

  init() {}
}

// MARK: - Индексатор перед вычисляемым свойством
struct ComputedBeforeSubscript {
  var value: Int { 1 }
  subscript(index: Int) -> Int { index }
}

/// Output
struct ComputedBeforeSubscript {

  subscript(index: Int) -> Int { index }

  var value: Int { 1 }
}

// MARK: - Требование индексатора перед требованием свойства
protocol Values {
  var value: Int { get }
  subscript(index: Int) -> Int { get }
}

/// Output
protocol Values {

  subscript(index: Int) -> Int { get }

  var value: Int { get }
}
