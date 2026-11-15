// MARK: - Несколько аннотаций членов протокола, включая условную компиляцию
protocol Example {

  #if os(macOS)
  @MainActor
  @available(*, deprecated)
  var conditionalValue: Int { get }
  #endif

  @MainActor
  @available(*, deprecated)
  func read() -> Int

  @MainActor
  @available(*, deprecated)
  init()

  @MainActor
  @available(*, deprecated)
  var value: Int { get }

  @MainActor
  @available(*, deprecated)
  subscript(index: Int) -> Int { get }
}

// MARK: - Несколько аннотаций свойства с наблюдателями
final class Example {

  @MainActor
  @available(*, deprecated)
  var value = 0 {
    didSet { _ = oldValue }
  }
}
