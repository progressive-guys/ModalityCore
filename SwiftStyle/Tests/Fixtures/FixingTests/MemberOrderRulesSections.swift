// MARK: - Input
enum Examples {

  struct InitializerBeforeStorage {
    init() {}
    var value = 1
  }

  struct ComputedBeforeInitializer {
    var value: Int { 1 }
    init() {}
  }

  struct FunctionBeforeComputed {
    func read() -> Int { value }
    var value: Int { 1 }
  }

  struct ObserverIsStored {
    init() {}
    var value = 0 { didSet {} }
  }

  final class SubscriptBeforeDeinit {
    subscript(index: Int) -> Int { index }
    deinit {}
  }

  struct ComputedBeforeSubscript {
    var value: Int { 1 }
    subscript(index: Int) -> Int { index }
  }

  final class DeinitBeforeInit {
    deinit {}
    init() {}
  }
}

// MARK: - Output
enum Examples {

  struct InitializerBeforeStorage {
    var value = 1

    init() {}
  }

  struct ComputedBeforeInitializer {
    init() {}

    var value: Int { 1 }
  }

  struct FunctionBeforeComputed {
    var value: Int { 1 }

    func read() -> Int { value }
  }

  struct ObserverIsStored {
    var value = 0 { didSet {} }

    init() {}
  }

  final class SubscriptBeforeDeinit {
    deinit {}

    subscript(index: Int) -> Int { index }
  }

  struct ComputedBeforeSubscript {
    subscript(index: Int) -> Int { index }

    var value: Int { 1 }
  }

  final class DeinitBeforeInit {
    init() {}

    deinit {}
  }
}
