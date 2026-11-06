public enum Examples {

  /// This syntax-only rule leaves call result types to the compiler.
  struct UnknownCallResultTypes {

    let a = f()
    let z = f()
    let m = "value"

    static func f() -> Int { 1 }
  }
}
