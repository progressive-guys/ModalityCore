enum Examples {

  static func optionalBinding(_ input: Int?) -> Int {
    if let item = input { return item }
    return 0
  }
}
