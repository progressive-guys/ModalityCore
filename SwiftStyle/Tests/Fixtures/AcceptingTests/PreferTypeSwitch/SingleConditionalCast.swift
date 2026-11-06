enum Examples {

  static func singleCheck(_ input: Any) -> Int {
    if let item = input as? String { return item.count }
    return 0
  }
}
