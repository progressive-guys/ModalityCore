public enum Examples {

  struct SeparateSmallTypeGroups {

    var a: Int
    var b : Int
    var c: String
    var d : String

    init(a: Int = 1, b: Int = 2, c: String = "three", d: String = "four") {
      self.a = a
      self.b = b
      self.c = c
      self.d = d
    }
  }
}
