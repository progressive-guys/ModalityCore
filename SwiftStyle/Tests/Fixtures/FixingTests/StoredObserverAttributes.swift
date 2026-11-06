// MARK: - Input
final class Example {
  @MainActor
  @available(*, deprecated)
  var value = 0 {
    didSet { _ = oldValue }
  }
}

// MARK: - Output
final class Example {

  @MainActor
  @available(*, deprecated)
  var value = 0 {
    didSet { _ = oldValue }
  }
}
