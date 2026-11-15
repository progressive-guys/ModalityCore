// MARK: - Явный инициализатор сохраняет значения по умолчанию и закрытый доступ
struct Values {
  private var longerName = 1
  public var x = 2
}

/// Output
struct Values {

  public var x: Int
  private var longerName: Int

  private init(longerName: Int = 1, x: Int = 2) {
    self.longerName = longerName
    self.x = x
  }
}

// MARK: - Явный инициализатор сохраняет порядок аргументов после сортировки свойств
struct Values {
  let longerName: Int
  let x: Int
}

func makeValues() -> Values { Values(longerName: 1, x: 2) }

/// Output
struct Values {

  let x: Int
  let longerName: Int

  init(longerName: Int, x: Int) {
    self.longerName = longerName
    self.x = x
  }
}

func makeValues() -> Values {
  Values(longerName: 1, x: 2)
}
