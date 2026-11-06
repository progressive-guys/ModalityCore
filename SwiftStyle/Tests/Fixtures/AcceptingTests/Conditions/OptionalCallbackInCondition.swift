enum Examples {

  static func optionalCall(_ callback: (() -> Bool)?) -> Bool {
    if callback?() == true { return true }
    return false
  }
}
