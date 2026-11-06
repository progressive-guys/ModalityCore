// MARK: - Input
enum Examples {

  struct GetterEffects {
    var delayed: Int { get async { 1 } }
    var fallible: Int { get throws { 2 } }
  }

  struct FunctionEffects {
    func combined() async throws {}
    func delayed() async {}
  }

  struct RethrowingEffects {
    func fallible(_ action: () throws -> Void) rethrows { try action() }
    func plain() {}
  }
}

// MARK: - Output
enum Examples {

  struct GetterEffects {
    var fallible: Int { get throws { 2 } }

    var delayed: Int { get async { 1 } }
  }

  struct FunctionEffects {
    func delayed() async {}

    func combined() async throws {}
  }

  struct RethrowingEffects {
    func plain() {}

    func fallible(_ action: () throws -> Void) rethrows { try action() }
  }
}
