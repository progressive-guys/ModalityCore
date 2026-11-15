// MARK: - Аннотация MainActor над функцией
@MainActor func value() -> Int {
  1
}

/// Output
@MainActor
func value() -> Int {
  1
}

// MARK: - Аннотация propertyWrapper переносится над объявлением типа
@propertyWrapper struct Box<Value> {
  var wrappedValue: Value
}

/// Output
@propertyWrapper
struct Box<Value> {
  var wrappedValue: Value
}
