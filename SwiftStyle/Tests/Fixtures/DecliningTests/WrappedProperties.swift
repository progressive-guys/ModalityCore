@propertyWrapper
struct Wrapped {
  var wrappedValue: Int
}

struct Example {
  @Wrapped var longerName: Int = 1
  @Wrapped var x: Int = 2
}

let value = Example(longerName: 3, x: 4)

@propertyWrapper
struct Box<T> {
  var wrappedValue: T
}

struct GenericExample {

  @Box var longerName: Int
  @Box var x: Int

  var result: Int { read() }

  func read() -> Int { longerName + x }
}

let generic = GenericExample(longerName: 2, x: 3)
