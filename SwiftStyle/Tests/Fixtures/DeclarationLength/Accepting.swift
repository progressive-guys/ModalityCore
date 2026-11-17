// MARK: - Свойства структуры уже упорядочены
struct Pair {

  let x: Int
  let longerName: Int
}

func makePair() -> Pair {
  Pair(x: 1, longerName: 2)
}

// MARK: - Порядок вариантов перечисления сохраняется
enum Code: Int, CaseIterable {

  case longerName
  case x
}

// MARK: - Порядок локальных инструкций сохраняется
func value() -> Int {
  let longerName = 1
  let x = 2
  return longerName + x
}

// MARK: - Порядок параметров сохраняется
func sum(longerName: Int, x: Int) -> Int {
  longerName + x
}

// MARK: - Объявления одинаковой длины сохраняют порядок
private protocol Values {

  var z: Int { get }
  var a: Int { get }
}
