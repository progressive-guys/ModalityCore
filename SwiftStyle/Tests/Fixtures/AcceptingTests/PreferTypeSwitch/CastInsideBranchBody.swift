enum Examples {

  static func castInBody(_ input: Any, _ ready: Bool) -> String? {
    if ready { return input as? String }
    return nil
  }
}
