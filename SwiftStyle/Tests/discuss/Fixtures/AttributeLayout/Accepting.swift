// MARK: - Комментарий между аннотацией и свойством
class Comments {

  @available(*, deprecated)
  // Keep this comment with the property.
  var value: Int = 0
}

// MARK: - Несколько аннотаций свойства протокола в условной компиляции
protocol Example {

  #if os(macOS)
  @MainActor
  @available(*, deprecated)
  var value: Int { get }
  #endif
}

// MARK: - Несколько аннотаций свойства с наблюдателями
final class Example {

  @MainActor
  @available(*, deprecated)
  var value = 0 {
    didSet { _ = oldValue }
  }
}

// MARK: - Несколько аннотаций метода протокола
protocol Example {

  @MainActor
  @available(*, deprecated)
  func read() -> Int
}

// MARK: - Несколько аннотаций инициализатора протокола
protocol Example {

  @MainActor
  @available(*, deprecated)
  init()
}

// MARK: - Несколько аннотаций свойства протокола
protocol Example {
  
  @MainActor
  @available(*, deprecated)
  var value: Int { get }
}

// MARK: - Несколько аннотаций индексатора протокола
protocol Example {
  
  @MainActor
  @available(*, deprecated)
  subscript(index: Int) -> Int { get }
}

// MARK: - Аннотация available хранимого свойства уже на отдельной строке
class Width120 {

  @available(*, deprecated, message: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
  var value: Int = 0
}
