// MARK: - Case ClosureValuedStorage
final class Values {
  var callback: () -> Int = { 1 }

  init() {}
}

// MARK: - Case LazyStoredProperty
final class Values {
  lazy var cached = 1

  init() {}
}
