// MARK: - Case AlreadyOrderedMemberwiseStruct
struct Pair {
  let x: Int
  let longerName: Int
}

func makePair() -> Pair {
  Pair(x: 1, longerName: 2)
}

// MARK: - Case EnumCasesKeepTheirOrder
enum Code: Int, CaseIterable {
  case longerName
  case x
}

// MARK: - Case LocalStatementsStayInOrder
func value() -> Int {
  let longerName = 1
  let x = 2
  return longerName + x
}

// MARK: - Case ParametersKeepTheirOrder
func sum(longerName: Int, x: Int) -> Int {
  longerName + x
}

// MARK: - Case StableEqualLengths
private protocol Values {
  var z: Int { get }
  var a: Int { get }
}
