// MARK: - Input
protocol EffectRequirements {

  var combined: Int { get async throws }
  var delayed: Int { get async }
  var fallible: Int { get throws }
  var plain: Int { get }
  func combinedCall() async throws
  func delayedCall() async
  func fallibleCall() throws
  func plainCall()
}

struct EffectMembers {

  var combined: Int { get async throws { 1 } }
  var delayed: Int { get async { 2 } }
  var fallible: Int { get throws { 3 } }
  // Keep this getter comment.
  var plainLongName: Int { 4 }
  var a: Int { 5 }
  func combinedCall() async throws {}
  func delayedCall() async {}
  func fallibleCall() throws {}
  func repeatCall(_ action: () throws -> Void) rethrows { try action() }
  func typedCall() throws(Never) {}
  // Keep this function comment.
  func plainLongNameCall() {}
  func aCall() {}
  func repeatCombined(_ action: () async throws -> Void) async rethrows { try await action() }
}

extension EffectMembers {

  func extensionAsync() async {}
  func extensionPlain() {}
}

struct ConditionalEffects {

  func combined() async throws {}
  #if os(macOS)
  func delayed() async {}
  #else
  func delayed() async {}
  #endif
  func plain() {}
}

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

// MARK: - Output
protocol EffectRequirements {

  var plain: Int { get }

  var fallible: Int { get throws }

  var delayed: Int { get async }

  var combined: Int { get async throws }

  func plainCall()

  func fallibleCall() throws

  func delayedCall() async

  func combinedCall() async throws
}

struct EffectMembers {

  // Keep this getter comment.
  var plainLongName: Int { 4 }
  var a: Int { 5 }

  var fallible: Int { get throws { 3 } }

  var delayed: Int { get async { 2 } }

  var combined: Int { get async throws { 1 } }

  // Keep this function comment.
  func plainLongNameCall() {}
  func aCall() {}

  func fallibleCall() throws {}
  func repeatCall(_ action: () throws -> Void) rethrows { try action() }
  func typedCall() throws(Never) {}

  func delayedCall() async {}

  func combinedCall() async throws {}
  func repeatCombined(_ action: () async throws -> Void) async rethrows { try await action() }
}

extension EffectMembers {
  func extensionPlain() {}

  func extensionAsync() async {}
}

struct ConditionalEffects {

  func plain() {}

  #if os(macOS)
  func delayed() async {}
  #else
  func delayed() async {}
  #endif

  func combined() async throws {}
}

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
