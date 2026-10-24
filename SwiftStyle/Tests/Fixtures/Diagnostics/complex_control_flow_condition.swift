// MARK: - Accepted

enum Accepted {
  static func apiInsertedResult(_ values: inout Set<Int>, _ value: Int) -> Bool {
    if values.insert(value).inserted { return true }
    return false
  }

  static func apiResult(_ value: Int, _ values: [Int]) -> Bool {
    if values.contains(value) { return true }
    return false
  }

  static func value(_ value: Int) -> Bool {
    if abs(value) > 0 { return true }
    return false
  }

  static func backticks(_ `default`: Int) -> Bool {
    if `default` > 0 { return true }
    return false
  }

  static func indexing(_ values: [Int], _ index: Int) -> Bool {
    if values[index] > 0 { return true }
    return false
  }

  // if abs(abs(value)) > 0 { return }
  static let text = #"if abs(abs(value)) > 0 { return }"#
  static var regex: Regex<(Substring, Substring)> { #/if check(value)/# }

  static func optionalCall(_ callback: (() -> Bool)?) -> Bool {
    if callback?() == true { return true }
    return false
  }

  static func repeatExcluded(_ value: Int) {
    repeat {
      print(value)
    } while abs(abs(value)) > 0
  }

  static func shortPredicate(_ values: [Int]) -> Bool {
    if values.contains(where: { $0 > 0 }) { return true }
    return false
  }

  static func simpleArithmetic(_ value: Int, _ offset: Int, _ limit: Int) -> Bool {
    if value + offset > limit { return true }
    return false
  }

  static func unicode(_ значение: Int) -> Bool {
    if значение > 0 { return true }
    return false
  }

  static func whileExcluded(_ value: Int) {
    while abs(abs(value)) > 0 { return }
  }

  static func caseWhere(_ value: Int) -> Bool {
    switch value {
    case let number where abs(abs(number)) > 0:
      return true
    default:
      return false
    }
  }

  enum Failure: Error {
    case invalid
  }

  static func catchWhere() -> Bool {
    do {
      throw Failure.invalid
    } catch where String(describing: type(of: error)).isEmpty {
      return true
    } catch {
      return false
    }
  }

  static func forBinding(_ values: [Int]) {
    for value in values
    where abs(abs(value)) > 0 {
      print(value)
    }
  }

  static func forWhere(_ values: [Int]) -> Void {
    for value in values where abs(abs(value)) > 0 {
      print(value)
    }
  }

  static func guardNestedCall(_ value: Int) -> Bool {
    guard abs(abs(value)) > 0 else { return false }

    return true
  }

  static func nestedComment(_ value: Int) -> Bool {
    if abs(/* input */ abs(value)) > 0 { return true }
    return false
  }

  static func nestedCall(_ value: Int) -> Bool {
    if abs(abs(value)) > 0 { return true }
    return false
  }

  static func typedBinding(_ text: String) -> Bool {
    if let parsed: Int = Int(text), abs(abs(parsed)) > 0 { return true }
    return false
  }

  static func deepShortCall(_ value: Int) -> Bool {
    if abs(abs(abs(value))) > 0 { return true }
    return false
  }

  static func multipleNestedCalls(_ first: Int, _ second: Int) -> Bool {
    if max(abs(first), abs(second)) > 0 { return true }
    return false
  }

  static func multilineNestedCall(_ value: Int) -> Bool {
    if abs(abs(
      value
    )) > 0 { return true }
    return false
  }

  static func nestedAtLimit(_ text: String) -> Bool {
    if text.hasPrefix("012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234".lowercased()) { return true }
    return false
  }
}

// MARK: - Rejected

enum Rejected {
  static func complexPredicate(_ value: Int, _ limit: Int, _ values: [Int]) -> Bool {
    if values.contains(where: { $0 > 0 && $0 < limit && $0 != value }) { return true }
    return false
  }

  static func multipleArithmetic(_ value: Int, _ offset: Int, _ limit: Int) -> Bool {
    if value + offset + 1 > limit { return true }
    return false
  }

  static func nestedOverLimit(_ text: String) -> Bool {
    if text.hasPrefix("0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345".lowercased()) { return true }
    return false
  }

  static func nestedArithmetic(_ value: Int, _ offset: Int) -> Bool {
    if abs(abs(value + offset + 1)) > 0 { return true }
    return false
  }

  static func nestedClosure(_ values: [Int]) -> Bool {
    if values.contains(where: { value in values.contains(where: { $0 == value }) }) { return true }
    return false
  }
}
