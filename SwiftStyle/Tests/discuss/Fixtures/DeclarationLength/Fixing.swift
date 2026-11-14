// MARK: - Case PureWrapperExplicitInitializer
// MARK: Input
@propertyWrapper
struct Box<Value> {
  var wrappedValue: Value
}

struct Values {
  @Box var longerName = 1
  @Box var x = 2
  init() {}
}

// MARK: Output
@propertyWrapper
struct Box<Value> {
  var wrappedValue: Value
}

struct Values {
  @Box var x = 2
  @Box var longerName = 1
  init() {}
}
