// MARK: - Case KnownWrapperJoinsDeclaration
// MARK: Input
@propertyWrapper
struct Injected<Value> {
  var wrappedValue: Value
}

struct Settings {
  @Injected
  var value = 1
}

// MARK: Output
@propertyWrapper
struct Injected<Value> {
  var wrappedValue: Value
}

struct Settings {
  @Injected var value = 1
}
