// MARK: - Input
protocol Example {
  @MainActor
  @available(*, deprecated)
  init()

  @MainActor
  @available(*, deprecated)
  subscript(index: Int) -> Int { get }

  @MainActor
  @available(*, deprecated)
  var value: Int { get }

  @MainActor
  @available(*, deprecated)
  func read() -> Int
}

// MARK: - Output
protocol Example {

  @MainActor
  @available(*, deprecated)
  init()

  @MainActor
  @available(*, deprecated)
  subscript(index: Int) -> Int { get }

  @MainActor
  @available(*, deprecated)
  var value: Int { get }

  @MainActor
  @available(*, deprecated)
  func read() -> Int
}
