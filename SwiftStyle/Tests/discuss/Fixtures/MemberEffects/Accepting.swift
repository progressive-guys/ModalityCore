// MARK: - Группировка throws, async throws и async rethrows
struct Calls {

  // Async throws и async rethrows остаются в одной группе
  func combined() async throws {}

  func repeated(_ action: () async throws -> Void) async rethrows {
    try await action()
  }

  // Типизированный throws с Never остаётся в группе throws
  func fallible() throws {}
  func typed() throws(Never) {}
}
