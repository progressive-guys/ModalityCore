// MARK: - Сортировка свойств с простой обёрткой при существующем явном инициализаторе
@propertyWrapper
struct Box<Value> {
  var wrappedValue: Value
}

struct Values {
  @Box var longerName = 1
  @Box var x = 2
  init() {}
}

/// Output
@propertyWrapper
struct Box<Value> {
  var wrappedValue: Value
}

struct Values {

  @Box var x = 2
  @Box var longerName = 1

  init() {}
}
