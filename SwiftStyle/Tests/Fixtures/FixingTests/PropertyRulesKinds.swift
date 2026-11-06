// MARK: - Input
public enum Wrappers {

  @propertyWrapper
  struct F<T> {

    var wrappedValue: T
  }
}

public enum Examples {

  struct StaticAfterInstance {

    let a = 1
    static let b = 2
  }

  struct LetAfterVar {

    var a = 1

    let b = 2
  }

  struct PlainPropertyAfterWrapper {
    @Wrappers.F var a: Int = 1
    var b = 2

    init() {}
  }
}

// MARK: - Output
public enum Wrappers {

  @propertyWrapper
  struct F<T> {
    var wrappedValue: T
  }
}

public enum Examples {

  struct StaticAfterInstance {
    static let b = 2
    let a = 1
  }

  struct LetAfterVar {

    let b = 2

    var a : Int

    init(a: Int = 1) {
      self.a = a
    }
  }

  struct PlainPropertyAfterWrapper {
    var b = 2
    @Wrappers.F var a: Int = 1

    init() {}
  }
}
