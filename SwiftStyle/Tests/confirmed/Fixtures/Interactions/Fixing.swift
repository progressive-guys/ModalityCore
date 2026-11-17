func requireBoth(_ first: Bool, _ second: Bool) {
  guard first else {
    return
  }

  guard second else {
    return
  }
}

/// Output
func requireBoth(_ first: Bool, _ second: Bool) {
  guard first else { return }
  guard second else { return }
}

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

// MARK: - Перенос параметров и сокращение guard в расширении
extension Int {

  func requirePositive() {
    guard self > 0 else {
      return
    }
  }

  func sum(_ first: Int,
    _ second: Int) -> Int { first + second }
}

/// Output
extension Int {

  func requirePositive() {
    guard self > 0 else { return }
  }

  func sum(
    _ first: Int,
    _ second: Int
  ) -> Int {
    first + second
  }
}
