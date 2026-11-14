// MARK: - Case AfterTypedBinding
enum Examples {

  static func typedBinding(_ text: String) -> Bool {
    if let parsed: Int = Int(text), abs(abs(parsed)) > 0 { return true }
    return false
  }
}

// MARK: - Case CaseWhereScope
enum Examples {

  static func caseWhere(_ value: Int) -> Bool {
    switch value {
    case let number where abs(abs(number)) > 0:
      return true

    default:
      return false
    }
  }
}

// MARK: - Case CatchWhereScope
enum Examples {

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
}

// MARK: - Case ClosurePredicate
enum Examples {

  static func shortPredicate(_ values: [Int]) -> Bool {
    if values.contains(where: { $0 > 0 }) { return true }
    return false
  }
}

// MARK: - Case CommentInsideCall
enum Examples {

  static func nestedComment(_ value: Int) -> Bool {
    if abs(/* input */ abs(value)) > 0 { return true }
    return false
  }
}

// MARK: - Case ForWhereScope
enum Examples {

  static func forWhere(_ values: [Int]) -> Void {
    for value in values where abs(abs(value)) > 0 {
      print(value)
    }
  }
}

// MARK: - Case MultilineCallShape
enum Examples {

  static func multilineNestedCall(_ value: Int) -> Bool {
    if abs(abs(
      value
    )) > 0 { return true }

    return false
  }
}

// MARK: - Case MutatingCallResult
enum Examples {

  static func apiInsertedResult(_ values: inout Set<Int>, _ value: Int) -> Bool {
    if values.insert(value).inserted { return true }
    return false
  }
}

// MARK: - Case OptionalInvocation
enum Examples {

  static func optionalCall(_ callback: (() -> Bool)?) -> Bool {
    if callback?() == true { return true }
    return false
  }
}

// MARK: - Case RepeatConditionScope
enum Examples {

  static func repeatExcluded(_ value: Int) {
    repeat {
      print(value)
    } while abs(abs(value)) > 0
  }
}

// MARK: - Case ShortArithmetic
enum Examples {

  static func simpleArithmetic(_ value: Int, _ offset: Int, _ limit: Int) -> Bool {
    if value + offset > limit { return true }
    return false
  }
}

// MARK: - Case ShortGuardCall
enum Examples {

  static func guardNestedCall(_ value: Int) -> Bool {
    guard abs(abs(value)) > 0 else { return false }
    return true
  }
}

// MARK: - Case ShortNestedCalls
enum Examples {

  static func deepShortCall(_ value: Int) -> Bool {
    if abs(abs(abs(value))) > 0 { return true }
    return false
  }
}

// MARK: - Case SubscriptExpression
enum Examples {

  static func indexing(_ values: [Int], _ index: Int) -> Bool {
    if values[index] > 0 { return true }
    return false
  }
}

// MARK: - Case WhileConditionScope
enum Examples {

  static func whileExcluded(_ value: Int) {
    while abs(abs(value)) > 0 { return }
  }
}

// MARK: - Case WidthBoundaryAccepted
enum Examples {

  static func nestedAtLimit(_ text: String) -> Bool {
    if text.hasPrefix("012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234".lowercased()) { return true }
    return false
  }
}
