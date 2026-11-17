// MARK: - Явный инициализатор сохраняет значения по умолчанию и закрытый доступ
struct Values {
  private var x = 2
  public var longerName = 1
}

/// Output
struct Values {

  public var longerName: Int = 1

  private var x: Int = 2
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
}

func makeValues() -> Values {
  Values(longerName: 1, x: 2)
}
