// MARK: - Порядок функций без эффектов, rethrows, async и async throws
struct Calls {
  func combined() async throws {}
  func delayed() async {}
  func fallible(_ action: () throws -> Void) rethrows { try action() }
  func plain() {}
}

/// Output
struct Calls {

  func plain() {}

  func fallible(_ action: () throws -> Void) rethrows { try action() }

  func delayed() async {}

  func combined() async throws {}
}

// MARK: - Обычная функция перемещается перед async внутри расширения
struct Calls {}

extension Calls {
  func delayed() async {}
  func plain() {}
}

/// Output
struct Calls {}

extension Calls {

  func plain() {}

  func delayed() async {}
}

// MARK: - Однородный условный блок async занимает место между обычными и async throws
struct ConditionalEffects {

  func combined() async throws {}
  #if os(macOS)
  func delayed() async {}
  #else
  func delayed() async {}
  #endif
  func plain() {}
}

/// Output
struct ConditionalEffects {

  func plain() {}

  #if os(macOS)
  func delayed() async {}
  #else
  func delayed() async {}
  #endif

  func combined() async throws {}
}

// MARK: - Внутри каждой условной ветки функции сортируются по эффектам
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

/// Output
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

// MARK: - Требования свойств и методов сортируются по async и throws
protocol Requirements {

  var combined: Int { get async throws }
  var delayed: Int { get async }
  var fallible: Int { get throws }
  var plain: Int { get }

  func combinedCall() async throws
  func delayedCall() async
  func fallibleCall() throws
  func plainCall()
}

/// Output
protocol Requirements {

  var plain: Int { get }

  var fallible: Int { get throws }

  var delayed: Int { get async }

  var combined: Int { get async throws }

  func plainCall()

  func fallibleCall() throws

  func delayedCall() async

  func combinedCall() async throws
}

// MARK: - Getter с throws перед getter с async
struct GetterEffects {
  var delayed: Int { get async { 1 } }
  var fallible: Int { get throws { 2 } }
}

/// Output
struct GetterEffects {

  var fallible: Int { get throws { 2 } }

  var delayed: Int { get async { 1 } }
}
