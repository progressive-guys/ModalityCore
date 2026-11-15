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

// MARK: - Сортировка требований свойств и методов протокола
private protocol Requirements {

  var longerName: Int { get }
  var x: Int { get }

  func value(for index: Int) -> Int
  func reset()
}

/// Output
private protocol Requirements {

  var x: Int { get }
  var longerName: Int { get }

  func reset()
  func value(for index: Int) -> Int
}
