public enum Examples {

  struct FourLineGetterWithBlankLines {

    var x: Int {
      let n = 1
      return n
    }

    func a() -> Int { 0 }
    func z() -> Int { x }
  }
}
