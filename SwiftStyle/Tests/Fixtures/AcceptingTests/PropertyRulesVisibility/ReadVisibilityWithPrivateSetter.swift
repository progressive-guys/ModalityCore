public enum Examples {

  struct ReadVisibilityWithPrivateSetter {

    public var b : Int
    public private(set) var a : Int
    var c : Int

    init(a: Int = 1, b: Int = 2, c: Int = 3) {
      self.a = a
      self.b = b
      self.c = c
    }
  }
}
