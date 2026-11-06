public enum Examples {

  @propertyWrapper
  struct F<T> {
    var wrappedValue: T
  }

  struct StaticLetVarThenWrappers {

    static let s = 0
    let a = 1

    var b = 2
    @Examples.F var y = 3
  }
}
