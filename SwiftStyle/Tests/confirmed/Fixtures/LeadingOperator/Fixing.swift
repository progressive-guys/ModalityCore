// MARK: - Бинарный и тернарный операторы начинают строки продолжения
func both(_ first: Bool, _ second: Bool) -> Bool {
  first &&
  second
}

func choose(_ flag: Bool, first: Int, second: Int) -> Int {
  flag ?
    first :
    second
}

/// Output
func both(_ first: Bool, _ second: Bool) -> Bool {
  first
    && second
}

func choose(_ flag: Bool, first: Int, second: Int) -> Int {
  flag
    ? first
    : second
}
