// MARK: - Input
protocol Example {
  #if os(macOS)
  @MainActor
  @available(*, deprecated)
  var value: Int { get }
  #endif
}

// MARK: - Output
protocol Example {

  #if os(macOS)
  @MainActor
  @available(*, deprecated)
  var value: Int { get }
  #endif
}
