// MARK: - Закрывающие скобки коллекций, вызовов и вложенных групп (1)
func arithmeticAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].count + 1)
}

func array(_ first: Int, _ second: Int) -> [Int] {
  [
    first,
    second]
}

func arguments(_ first: Int, _ second: Int) -> Int {
  max(first,
    second)
}

func dictionary(_ first: Int, _ second: Int) -> [String: Int] {
  ["first": first,
    "second": second]
}

/// Output
func arithmeticAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].count + 1
  )
}

func array(_ first: Int, _ second: Int) -> [Int] {
  [
    first,
    second
  ]
}

func arguments(_ first: Int, _ second: Int) -> Int {
  max(first,
    second
  )
}

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

// MARK: - Закрывающие скобки строкового вызова, индексирования, группы и кортежа
func singleLineString() -> Int? {
  Int(
    "1")
}

func subscriptCall(_ first: Int, _ second: Int) -> Int {
  [first, second][
    0]
}

func ternaryAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].isEmpty ? 0 : first)
}

func tuple(_ first: Int, _ second: Int) -> (Int, Int) {
  (
    first,
    second)
}

/// Output
func singleLineString() -> Int? {
  Int(
    "1"
  )
}

func subscriptCall(_ first: Int, _ second: Int) -> Int {
  [first, second][
    0
  ]
}

func ternaryAfterCollection(_ first: Int) -> Int {
  ([
    first
  ].isEmpty ? 0 : first
  )
}

func tuple(_ first: Int, _ second: Int) -> (Int, Int) {
  (
    first,
    second
  )
}
