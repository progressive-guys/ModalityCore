// MARK: - Внешние скобки и запятые вложенных выражений
// Коллекция сохраняет внешние скобки
func count(values: [Int]) -> Int {
  values.count
}

let result = count(values: [
  1,
  2
])

// Запятые вложенных выражений остаются внутри них
func evaluate(
  _ pair: (Int, Int),
  transform: (Int, Int) -> Int
) -> Int {
  transform(pair.0, pair.1)
}
