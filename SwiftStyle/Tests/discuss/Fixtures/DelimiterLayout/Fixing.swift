// MARK: - Закрывающая скобка группы переносится после арифметики над коллекцией
func arithmeticAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].count + 1)
}

/// Output
func arithmeticAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].count + 1
  )
}

// MARK: - Закрывающая скобка массива переносится на отдельную строку
func array(_ first: Int, _ second: Int) -> [Int] {
  [
    first,
    second]
}

/// Output
func array(_ first: Int, _ second: Int) -> [Int] {
  [
    first,
    second
  ]
}

// MARK: - Закрывающая скобка вызова переносится на отдельную строку
func arguments(_ first: Int, _ second: Int) -> Int {
  max(first,
    second)
}

/// Output
func arguments(_ first: Int, _ second: Int) -> Int {
  max(first,
    second
  )
}

// MARK: - Закрывающая скобка словаря переносится на отдельную строку
func dictionary(_ first: Int, _ second: Int) -> [String: Int] {
  ["first": first,
    "second": second]
}

/// Output
func dictionary(_ first: Int, _ second: Int) -> [String: Int] {
  ["first": first,
    "second": second
  ]
}

// MARK: - Закрывающая скобка внешнего вызова переносится после вызова замыкания
func sameLineClosureBody(_ first: Int) -> Int {
  Int({
    first + 1 }())
}

/// Output
func sameLineClosureBody(_ first: Int) -> Int {
  Int({
    first + 1 }()
  )
}

// MARK: - Выражение getter переносится со строки открывающей скобки в тело
enum Examples {
  static var value: Int { 1
  }
}

/// Output
enum Examples {

  static var value: Int {
    1
  }
}

// MARK: - Закрывающая скобка вызова переносится после строкового аргумента
func singleLineString() -> Int? {
  Int(
    "1")
}

/// Output
func singleLineString() -> Int? {
  Int(
    "1"
  )
}

// MARK: - Закрывающая скобка индексирования переносится на отдельную строку
func subscriptCall(_ first: Int, _ second: Int) -> Int {
  [first, second][
    0]
}

/// Output
func subscriptCall(_ first: Int, _ second: Int) -> Int {
  [first, second][
    0
  ]
}

// MARK: - Закрывающая скобка группы переносится после тернарного выражения
func ternaryAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].isEmpty ? 0 : first)
}

/// Output
func ternaryAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].isEmpty ? 0 : first
  )
}

// MARK: - Закрывающая скобка кортежа переносится на отдельную строку
func tuple(_ first: Int, _ second: Int) -> (Int, Int) {
  (
    first,
    second)
}

/// Output
func tuple(_ first: Int, _ second: Int) -> (Int, Int) {
  (
    first,
    second
  )
}
