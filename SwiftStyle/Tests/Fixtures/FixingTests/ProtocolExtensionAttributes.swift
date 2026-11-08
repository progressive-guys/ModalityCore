// MARK: - Input
@MainActor @available(*, deprecated) protocol Example {
  @available(*, deprecated)
  func value() -> Int
}

extension Example {
  @available(*, deprecated) func value() -> Int { 0 }
}

// MARK: - Output
@MainActor
@available(*, deprecated)
protocol Example {
  @available(*, deprecated)
  func value() -> Int
}

extension Example {
  @available(*, deprecated)
  func value() -> Int { 0 }
}
