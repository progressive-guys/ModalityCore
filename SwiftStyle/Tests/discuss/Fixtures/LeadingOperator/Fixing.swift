// MARK: - Бинарный оператор начинает строку продолжения
func both(_ first: Bool, _ second: Bool) -> Bool {
  first &&
  second
}

/// Output
func both(_ first: Bool, _ second: Bool) -> Bool {
  first
    && second
}

// MARK: - Знаки тернарного оператора начинают строки веток
func choose(_ flag: Bool, first: Int, second: Int) -> Int {
  flag ?
    first :
    second
}

/// Output
func choose(_ flag: Bool, first: Int, second: Int) -> Int {
  flag
    ? first
    : second
}
