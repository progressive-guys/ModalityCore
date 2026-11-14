// MARK: - Case AssignmentRhsJoinsEquals
// MARK: Input
enum Examples {
  static func value(_ source: Int) -> Int {
    let result =
      source
    return result
  }
}

// MARK: Output
enum Examples {

  static func value(_ source: Int) -> Int {
    let result = source
    return result
  }
}

// MARK: - Case ConditionalCastJoinsOperand
// MARK: Input
enum Examples {
  static func value(_ source: Any) -> Int? {
    source
      as? Int
  }
}

// MARK: Output
enum Examples {
  static func value(_ source: Any) -> Int? {
    source as? Int
  }
}

// MARK: - Case SelfMemberJoinsBase
// MARK: Input
enum Examples {
  static func value() {
    struct Value {
      let member: Int
      var value: Int { self
        .member
      }
    }
  }
}

// MARK: Output
enum Examples {

  static func value() {
    struct Value {

      let member: Int

      var value: Int {
        self.member
      }
    }
  }
}
