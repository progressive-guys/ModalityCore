// MARK: - Case CollectionKeepsOuterDelimiters
func count(values: [Int]) -> Int {
  values.count
}

let result = count(values: [
  1,
  2
])

// MARK: - Case NestedCommasStayNested
func evaluate(
  _ pair: (Int, Int),
  transform: (Int, Int) -> Int
) -> Int {
  transform(pair.0, pair.1)
}
