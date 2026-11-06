// MARK: - Input
struct Example {
  #if os(macOS)
  @MainActor @available(*, deprecated)
  #else
  @MainActor @available(*, unavailable)
  #endif
  var value: Int { 0 }
}

// MARK: - Output
struct Example {

  #if os(macOS)
  @MainActor
  @available(*, deprecated)
  #else
  @MainActor
  @available(*, unavailable)
  #endif
  var value: Int { 0 }
}
