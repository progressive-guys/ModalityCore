// MARK: - Input
enum Examples {
  static func unrelatedCheck(_ input: Int) {
    let value = input
    guard input > 0 else { return }

    print(value)
    print("done")
  }

  static func bodyUseContinuesGroup(_ input: Int) {
    let value = input
    if input > 0 { print(value) }
    print("done")
    print(input)
  }

  static func memberNameIsSeparate(_ input: (value: Int, other: Int)) {
    let value = input.other
    guard input.value > 0 else { return }

    print(value)
    print("done")
  }

  static func shadowedBindingIsSeparate(_ input: Int?) {
    let value = input
    if let value = Optional(1), value > 0 { print(value) }

    print(value as Any)
    print("done")
  }

  static func shadowedPatternIsSeparate(_ input: Int?) {
    let value = input
    if case .some(let value) = Optional(1), value > 0 { print(value) }

    print(value as Any)
    print("done")
  }

  static func closureUseIsSeparate(_ input: Int) {
    let value = input
    if [1].contains(where: { value in value > 0 }) { print(input) }

    print(value)
    print("done")
  }

  static func commentStartsGroup(_ input: Int) {
    let value = input
    // Validate the input.
    guard value > 0 else { return }

    print(value)
  }
}

// MARK: - Output
enum Examples {

  static func unrelatedCheck(_ input: Int) {
    let value = input

    guard input > 0 else { return }

    print(value)
    print("done")
  }

  static func bodyUseContinuesGroup(_ input: Int) {
    let value = input
    if input > 0 {
      print(value)
    }

    print("done")
    print(input)
  }

  static func memberNameIsSeparate(_ input: (value: Int, other: Int)) {
    let value = input.other

    guard input.value > 0 else { return }

    print(value)
    print("done")
  }

  static func shadowedBindingIsSeparate(_ input: Int?) {
    let value = input

    if let value = Optional(1), value > 0 {
      print(value)
    }

    print(value as Any)
    print("done")
  }

  static func shadowedPatternIsSeparate(_ input: Int?) {
    let value = input

    if case .some(let value) = Optional(1), value > 0 {
      print(value)
    }

    print(value as Any)
    print("done")
  }

  static func closureUseIsSeparate(_ input: Int) {
    let value = input

    if [1].contains(where: { value in value > 0 }) {
      print(input)
    }

    print(value)
    print("done")
  }

  static func commentStartsGroup(_ input: Int) {
    let value = input

    // Validate the input.
    guard value > 0 else { return }
    print(value)
  }
}
