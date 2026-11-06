enum Examples {

  static func status(_ failure: String?) -> String {
    var value = "a; return"
    if let failure {
      value = "Error: \(failure)"
      return value
    }
    return value
  }
}
