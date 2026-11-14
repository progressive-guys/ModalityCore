// MARK: - Case AsyncBeforeAsyncThrowing
// MARK: Input
struct FunctionEffects {
  func combined() async throws {}
  func delayed() async {}
}

// MARK: Output
struct FunctionEffects {

  func delayed() async {}

  func combined() async throws {}
}

// MARK: - Case ExtensionScope
// MARK: Input
struct Calls {}

extension Calls {
  func delayed() async {}
  func plain() {}
}

// MARK: Output
struct Calls {}

extension Calls {

  func plain() {}

  func delayed() async {}
}

// MARK: - Case HomogeneousConditionalRegion
// MARK: Input
struct ConditionalEffects {

  func combined() async throws {}
  #if os(macOS)
  func delayed() async {}
  #else
  func delayed() async {}
  #endif
  func plain() {}
}

// MARK: Output
struct ConditionalEffects {

  func plain() {}

  #if os(macOS)
  func delayed() async {}
  #else
  func delayed() async {}
  #endif

  func combined() async throws {}
}

// MARK: - Case MixedConditionalRegion
// MARK: Input
struct MixedConditionalEffects {

  func before() async {}
  #if os(macOS)
  func delayed() async {}
  func plain() {}
  #else
  func fallible() throws {}
  func plain() {}
  #endif
  func after() {}
}

// MARK: Output
struct MixedConditionalEffects {

  func before() async {}
  #if os(macOS)
  func plain() {}

  func delayed() async {}
  #else
  func plain() {}

  func fallible() throws {}
  #endif
  func after() {}
}

// MARK: - Case PlainBeforeRethrowing
// MARK: Input
struct RethrowingEffects {
  func fallible(_ action: () throws -> Void) rethrows { try action() }
  func plain() {}
}

// MARK: Output
struct RethrowingEffects {

  func plain() {}

  func fallible(_ action: () throws -> Void) rethrows { try action() }
}

// MARK: - Case ProtocolGetterEffects
// MARK: Input
protocol Values {

  var combined: Int { get async throws }
  var delayed: Int { get async }
  var fallible: Int { get throws }
  var plain: Int { get }
}

// MARK: Output
protocol Values {

  var plain: Int { get }

  var fallible: Int { get throws }

  var delayed: Int { get async }

  var combined: Int { get async throws }
}

// MARK: - Case ProtocolMethodEffects
// MARK: Input
protocol Calls {

  func combinedCall() async throws
  func delayedCall() async
  func fallibleCall() throws
  func plainCall()
}

// MARK: Output
protocol Calls {

  func plainCall()

  func fallibleCall() throws

  func delayedCall() async

  func combinedCall() async throws
}

// MARK: - Case ThrowingGetterBeforeAsync
// MARK: Input
struct GetterEffects {
  var delayed: Int { get async { 1 } }
  var fallible: Int { get throws { 2 } }
}

// MARK: Output
struct GetterEffects {

  var fallible: Int { get throws { 2 } }

  var delayed: Int { get async { 1 } }
}
