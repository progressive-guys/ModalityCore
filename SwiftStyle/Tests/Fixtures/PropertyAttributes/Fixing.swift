// MARK: - Аннотация Injected помещается на строке хранимого свойства
@propertyWrapper
struct Injected<Value> {
  var wrappedValue: Value
}

struct Settings {
  @Injected
  var value = 1
}

/// Output
@propertyWrapper
struct Injected<Value> {
  var wrappedValue: Value
}

struct Settings {
  @Injected var value = 1
}
