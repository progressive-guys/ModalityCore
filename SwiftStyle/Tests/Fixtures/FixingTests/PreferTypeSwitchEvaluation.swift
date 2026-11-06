// MARK: - Input
enum Examples {
  struct Box { var value: Any { "value" } }

  enum Failure: Error { case unsupported }

  static func repeatedProperties(_ input: Box) -> Int {
    if input.value is String { return 1 }
    if input.value is Int { return 2 }
    if input.value is Bool { return 3 }
    return 0
  }

  static func throwsFromEachBranch(_ input: Any) throws -> Int {
    if input is String { throw Failure.unsupported }
    if input is Int { throw Failure.unsupported }
    return 0
  }
}

// MARK: - Output
enum Examples {

  struct Box {
    var value: Any { "value" } }

  enum Failure: Error {
    case unsupported
  }

  static func repeatedProperties(_ input: Box) -> Int {
    switch (input.value) {
    case is String:
      return 1

    default:
      break
    }

    switch (input.value) {
    case is Int:
      return 2

    default:
      break
    }

    switch (input.value) {
    case is Bool:
      return 3

    default:
      break
    }

    return 0
  }

  static func throwsFromEachBranch(_ input: Any) throws -> Int {
    switch (input) {
    case is String:
      throw Failure.unsupported

    default:
      break
    }

    switch (input) {
    case is Int:
      throw Failure.unsupported

    default:
      break
    }

    return 0
  }
}
