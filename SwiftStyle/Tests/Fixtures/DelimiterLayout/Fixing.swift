// MARK: - Закрывающие скобки коллекций, вызовов и вложенных групп (1)
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
func array(_ first: Int, _ second: Int) -> [Int] {
  [
    first,
    second
  ]
}

func arguments(_ first: Int, _ second: Int) -> Int {
  max(
    first,
    second
  )
}

func dictionary(_ first: Int, _ second: Int) -> [String: Int] {
  [
    "first": first,
    "second": second
  ]
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
