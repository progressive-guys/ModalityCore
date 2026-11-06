public enum Examples {

  @propertyWrapper
  struct F<T> {
    var wrappedValue: T
  }

  struct WrapperArgumentsKeepOneGroup {
    @Examples.F(wrappedValue: 1) var a: Int
    @Examples.F(wrappedValue: 2) var b: Int
  }
}
