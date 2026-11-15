// MARK: - Скобка тела остаётся после вложенного вызова в условии
func choose(first: Int, second: Int) -> Int? {
  first > second ? first : nil
}

func maximum(_ first: Int, _ second: Int) -> Int {
  if let result = choose(
    first: first,
    second: second
  ) {
    return result
  }

  return second
}
