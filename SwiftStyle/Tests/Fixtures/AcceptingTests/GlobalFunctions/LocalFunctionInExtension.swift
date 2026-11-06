enum Examples {}

extension Examples {

  static func outer() {
    func local() {}
    local()
  }
}
