// MARK: - Input
public enum Examples {

  struct RepeatedExplicitTypeGroup {
    var a: Int = 1
    var m: String = "value"
    var z: Int = 2
  }

  struct RepeatedInferredTypeGroup {
    var a = 1
    var m = "value"
    var z = -2
  }

  struct RepeatedConstructorTypeGroup {
    let a = String("one")
    let m = 1
    let z = String("two")
  }

  struct RepeatedSharedTypeGroup {
    var a, b: Int
    var s = "value"
    var z = 3

    init(a: Int, b: Int) {
      self.a = a
      self.b = b
    }
  }

  struct RepeatedArrayTypeGroup {
    var a: [Int] = []
    var s = "value"
    var z: Array<Int> = []
  }
}

// MARK: - Output
public enum Examples {

  struct RepeatedExplicitTypeGroup {

    var a: Int 
    var z: Int 
    var m: String 

    init(a: Int = 1, m: String = "value", z: Int = 2) {
      self.a = a
      self.m = m
      self.z = z
    }
  }

  struct RepeatedInferredTypeGroup {

    var a : Int
    var z : Int
    var m : String

    init(a: Int = 1, m: String = "value", z: Int = -2) {
      self.a = a
      self.m = m
      self.z = z
    }
  }

  struct RepeatedConstructorTypeGroup {
    let m = 1
    let a = String("one")
    let z = String("two")
  }

  struct RepeatedSharedTypeGroup {

    var z = 3
    var a, b: Int
    var s = "value"

    init(a: Int, b: Int) {
      self.a = a
      self.b = b
    }
  }

  struct RepeatedArrayTypeGroup {

    var a: [Int] 
    var s : String
    var z: Array<Int> 

    init(a: [Int] = [], s: String = "value", z: Array<Int> = []) {
      self.a = a
      self.s = s
      self.z = z
    }
  }
}
