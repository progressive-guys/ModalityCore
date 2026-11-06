public enum Examples {

  struct EquivalentArrayTypeSpellings {

    var a: [Int]
    var m : String
    var b: Array<Int>

    init(a: [Int] = [], b: Array<Int> = [], m: String = "value") {
      self.a = a
      self.b = b
      self.m = m
    }
  }
}
