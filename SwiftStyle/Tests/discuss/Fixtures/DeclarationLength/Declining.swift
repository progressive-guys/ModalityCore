// MARK: - Case ConcreteMemberwiseWrapper
@propertyWrapper
struct Wrapped {
  var wrappedValue: Int
}

struct Example {
  @Wrapped var longerName: Int = 1
  @Wrapped var x: Int = 2
}

func makeExample() -> Example { Example(longerName: 3, x: 4) }

// MARK: - Case GenericMemberwiseWrapper
@propertyWrapper
struct Box<T> {
  var wrappedValue: T
}

struct GenericExample {
  @Box var longerName: Int
  @Box var x: Int
}

func makeExample() -> GenericExample { GenericExample(longerName: 3, x: 4) }

// MARK: - Case MemberwiseInitializer
struct Pair {
  let longerName: Int
  let x: Int
}

func makePair() -> Pair {
  Pair(longerName: 1, x: 2)
}

// MARK: - Case StoredInitializerEffects
private func trace(_ value: Int) -> Int {
  print(value)
  return value
}

private final class Values {
  let longerName = trace(1)
  let x = trace(2)
}

// MARK: - Case WrapperInitialization
@propertyWrapper
struct Recorded<Value> {
  var wrappedValue: Value

  init(wrappedValue: Value) {
    print("initializing", wrappedValue)
    self.wrappedValue = wrappedValue
  }
}

final class Values {
  @Recorded var longerName = 1
  @Recorded var x = 2
}
