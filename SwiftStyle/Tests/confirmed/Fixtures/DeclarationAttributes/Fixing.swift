// MARK: - Case MainActorFunctionOnSeparateLine
// MARK: Input
@MainActor func value() -> Int {
  1
}

// MARK: Output
@MainActor
func value() -> Int {
  1
}

// MARK: - Case PropertyWrapperTypeAttribute
// MARK: Input
@propertyWrapper struct Box<Value> {
  var wrappedValue: Value
}

// MARK: Output
@propertyWrapper
struct Box<Value> {
  var wrappedValue: Value
}
