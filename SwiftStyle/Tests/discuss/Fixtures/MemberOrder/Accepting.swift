// MARK: - Хранимое свойство со значением-замыканием
final class Values {

  var callback: () -> Int = { 1 }

  init() {}
}

// MARK: - Ленивое хранимое свойство
final class Values {

  lazy var cached = 1

  init() {}
}
