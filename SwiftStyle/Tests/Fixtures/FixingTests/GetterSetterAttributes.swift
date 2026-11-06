// MARK: - Input
struct Example {
  @MainActor @available(*, deprecated) var value: Int {
    get { 0 }
    set { _ = newValue }
  }
}

// MARK: - Output
struct Example {

  @MainActor
  @available(*, deprecated)
  var value: Int {
    get { 0 }
    set { _ = newValue }
  }
}
