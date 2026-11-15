// MARK: - Сортировка по длине объявления, а не имени
enum Windows {
  static let a = "a substantially longer literal"
  static let longerName = "x"
}

/// Output
enum Windows {

  static let longerName = "x"
  static let a = "a substantially longer literal"
}

// MARK: - Сортировка требований к методам протокола
private protocol Actions {
  func value(for index: Int) -> Int
  func reset()
}

/// Output
private protocol Actions {

  func reset()
  func value(for index: Int) -> Int
}

// MARK: - Сортировка требований протокола
private protocol Values {
  var longerName: Int { get }
  var x: Int { get }
}

/// Output
private protocol Values {

  var x: Int { get }
  var longerName: Int { get }
}
