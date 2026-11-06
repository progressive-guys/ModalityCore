public enum Examples {

  struct MethodsEndPropertyGroups {

    var a = 1
    var b = 2
    var c = 3

    func readFirst() -> Int { a }
    func readSecond() -> Int { b }
    func readThird() -> Int { c }
  }
}
