// MARK: - Async throws и async rethrows остаются в одной группе
struct Calls {

  func combined() async throws {}
  func repeated(_ action: () async throws -> Void) async rethrows {
    try await action()
  }
}

// MARK: - Типизированный throws с Never остаётся в группе throws
struct Calls {

  func fallible() throws {}
  func typed() throws(Never) {}
}
