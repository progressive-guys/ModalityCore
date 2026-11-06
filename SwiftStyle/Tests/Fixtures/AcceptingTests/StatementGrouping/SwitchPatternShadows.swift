enum Examples {

  static func process(_ input: Int, alternative: Int?) {
    let value = input

    switch alternative {
    case .some(let value): print(value)
    case .none: break
    }

    print(value)
  }
}
