// MARK: - Case AlternatingDisjunctionReceivers
enum Examples {

  static func alternatingObjects(_ input: Any, _ second: Any) -> Bool {
    if input is String || second is String || input is Bool { return true }
    return false
  }
}

// MARK: - Case BindingBreaksSeries
enum Examples {

  static func unconditionalCast(_ input: Any) -> Int {
    if let item = input as? String { return item.count }

    let item = input as Any
    if item is Bool { return 3 }

    return 0
  }
}

// MARK: - Case CastInBranchBody
enum Examples {

  static func castInBody(_ input: Any, _ ready: Bool) -> String? {
    if ready { return input as? String }
    return nil
  }
}

// MARK: - Case DifferentReceivers
enum Examples {

  static func differentReceiver(_ input: Any, _ second: Any) -> Int {
    if input is String { return 1 }
    if second is Int { return 2 }
    return 0
  }
}

// MARK: - Case RepeatedCallReceiver
enum Examples {

  static func repeatedCalls(_ make: () -> Any) -> Int {
    if make() is String { return 1 }
    if make() is Int { return 2 }
    if make() is Bool { return 3 }

    return 0
  }
}

// MARK: - Case SingleCast
enum Examples {

  static func singleCheck(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    return 0
  }
}

// MARK: - Case SingleTest
enum Examples {

  static func singleTypeTest(_ input: Any) -> Bool {
    if input is String { return true }
    return false
  }
}

// MARK: - Case StatementBreaksSeries
enum Examples {

  static func interruption(_ input: Any) -> Int {
    if input is String { return 1 }

    print("step")

    if input is Int { return 2 }

    return 0
  }
}

// MARK: - Case TestInsideClosure
enum Examples {

  static func closurePredicate(_ values: [Any]) -> Bool {
    if values.contains(where: { $0 is Int }) { return true }
    return false
  }
}
