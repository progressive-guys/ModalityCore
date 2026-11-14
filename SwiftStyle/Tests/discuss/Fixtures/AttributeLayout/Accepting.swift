// MARK: - Case CommentBetweenAttributeAndProperty
class Comments {

  @available(*, deprecated)
  // Keep this comment with the property.
  var value: Int = 0
}

// MARK: - Case ConditionalProtocolPropertyAttributeStack
protocol Example {

  #if os(macOS)
  @MainActor
  @available(*, deprecated)
  var value: Int { get }
  #endif
}

// MARK: - Case ObserverPropertyAttributeStack
final class Example {

  @MainActor
  @available(*, deprecated)
  var value = 0 {
    didSet { _ = oldValue }
  }
}

// MARK: - Case ProtocolFunctionAttributeStack
protocol Example {

  @MainActor
  @available(*, deprecated)
  func read() -> Int
}

// MARK: - Case ProtocolInitializerAttributeStack
protocol Example {

  @MainActor
  @available(*, deprecated)
  init()
}

// MARK: - Case ProtocolPropertyAttributeStack
protocol Example {
  
  @MainActor
  @available(*, deprecated)
  var value: Int { get }
}

// MARK: - Case ProtocolSubscriptAttributeStack
protocol Example {
  
  @MainActor
  @available(*, deprecated)
  subscript(index: Int) -> Int { get }
}

// MARK: - Case StoredAvailabilityAlreadySeparate
class Width120 {

  @available(*, deprecated, message: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
  var value: Int = 0
}
