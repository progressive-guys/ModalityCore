// MARK: - Перенос аннотации и исправление отступа тела функции
struct Example {
  @MainActor static func value() -> Int {
      1
  }
}

/// Output
struct Example {

  @MainActor
  static func value() -> Int {
    1
  }
}

// MARK: - Исправление отступов тела замыкания и следующего вызова в цепочке
func adjusted(_ values: [Int]) -> [Int] {
  values.map {
      $0 + 1
  }
    .filter { $0 > 0 }
}

/// Output
func adjusted(_ values: [Int]) -> [Int] {
  values.map {
    $0 + 1
  }
  .filter { $0 > 0 }
}

// MARK: - Guard сокращается, пустая строка в начале расширения сохраняется
extension Int {

  func requirePositive() {
    guard self > 0 else {
      return
    }
  }
}

/// Output
extension Int {

  func requirePositive() {
    guard self > 0 else { return }
  }
}

// MARK: - Перенос списка увеличивает число строк тела типа
extension Int {
  func sum(_ first: Int,
    _ second: Int) -> Int { first + second }
}

/// Output
extension Int {

  func sum(
    _ first: Int,
    _ second: Int
  ) -> Int { first + second }
}

// MARK: - Сортировка объявлений и пустая строка в начале типа
private protocol Values {
  var longestName: Int { get }
  var longName: Int { get }
  var mid: Int { get }
  var x: Int { get }
}

/// Output
private protocol Values {

  var x: Int { get }
  var mid: Int { get }
  var longName: Int { get }
  var longestName: Int { get }
}
