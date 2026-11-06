// MARK: - Input
enum Examples {
  static func uniqued(_ input: [Int]) -> [Int] {
    var set = Set<Int>()

    return input.filter { set.insert($0).inserted }
  }

  static func threeCodeLines(_ input: Int) -> Int {
    let value = input
    print(value)

    return value
  }

  static func twoBlankLinesBeforeReturn() -> Int {
    let x = 1


    return x
  }

  static func blankLineBetweenLocalDeclarations() -> Int {
    let a = 1

    let b = 2
    return a + b
  }

  static func blankLineBetweenCompactChecks(_ x: Int) -> Int {
    if x == 1 { return 1 }

    if x == 2 { return 2 }
    return x
  }

  static func checkedLocalInShortScope(_ input: Int) {
    let value = input
    guard value > 0 else { return }
    print(input)
  }

  static func differentLocalTypesTogether() -> String {
    let k = 1
    let name = "value"
    return name + String(k)
  }

  static func returnKeepsItsGroup(_ input: Int) -> Int {
    let value = input

    guard value > 0 else { return 0 }
    return value
  }
}

// MARK: - Output
enum Examples {

  static func uniqued(_ input: [Int]) -> [Int] {
    var set = Set<Int>()
    return input.filter { set.insert($0).inserted }
  }

  static func threeCodeLines(_ input: Int) -> Int {
    let value = input
    print(value)
    return value
  }

  static func twoBlankLinesBeforeReturn() -> Int {
    let x = 1
    return x
  }

  static func blankLineBetweenLocalDeclarations() -> Int {
    let a = 1
    let b = 2
    return a + b
  }

  static func blankLineBetweenCompactChecks(_ x: Int) -> Int {
    if x == 1 { return 1 }
    if x == 2 { return 2 }
    return x
  }

  static func checkedLocalInShortScope(_ input: Int) {
    let value = input
    guard value > 0 else { return }
    print(input)
  }

  static func differentLocalTypesTogether() -> String {
    let k = 1
    let name = "value"
    return name + String(k)
  }

  static func returnKeepsItsGroup(_ input: Int) -> Int {
    let value = input
    guard value > 0 else { return 0 }
    return value
  }
}
