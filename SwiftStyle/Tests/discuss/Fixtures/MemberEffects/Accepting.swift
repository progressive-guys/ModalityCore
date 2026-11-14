// MARK: - Case AsyncRethrowingCategory
struct Calls {

  func combined() async throws {}
  func repeated(_ action: () async throws -> Void) async rethrows {
    try await action()
  }
}

// MARK: - Case TypedNeverStaysThrowingCategory
struct Calls {

  func fallible() throws {}
  func typed() throws(Never) {}
}
