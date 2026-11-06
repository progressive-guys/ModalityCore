// MARK: - Input
public enum Wrappers {

  @propertyWrapper
  struct F<T> {

    var wrappedValue: T
  }

  @propertyWrapper
  struct G<T> {

    var wrappedValue: T
  }
}

public enum Examples {

  struct RepeatedWrapperGroup {
    @Wrappers.F var a: Int = 1
    @Wrappers.G var m: Int = 2
    @Wrappers.F var z: Int = 3

    init() {}
  }
}

// MARK: - Output
public enum Wrappers {

  @propertyWrapper
  struct F<T> {
    var wrappedValue: T
  }

  @propertyWrapper
  struct G<T> {
    var wrappedValue: T
  }
}

public enum Examples {

  struct RepeatedWrapperGroup {

    @Wrappers.F var a: Int = 1
    @Wrappers.F var z: Int = 3
    @Wrappers.G var m: Int = 2

    init() {}
  }
}
