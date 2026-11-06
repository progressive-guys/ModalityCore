// MARK: - Input
final class Example {
  #if os(macOS)
  @available(*, deprecated) @MainActor
  #endif
  var value = 0
}

// MARK: - Output
final class Example {

  #if os(macOS)
  @available(*, deprecated)
  @MainActor
  #endif
  var value = 0
}
