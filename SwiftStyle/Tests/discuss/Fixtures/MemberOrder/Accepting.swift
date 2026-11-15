// MARK: - Хранимые свойства с замыканием и lazy перед инициализатором
final class Values {

  var callback: () -> Int = { 1 }

  lazy var cached = 1

  init() {}
}
