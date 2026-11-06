enum Examples {

  static func unconditionalCast(_ input: Any) -> Int {
    if let item = input as? String { return item.count }

    let item = input as Any
    if item is Bool { return 3 }

    return 0
  }
}
