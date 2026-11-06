public enum Examples {

  struct IndependentConditionalBranches {

    #if os(macOS)
    public var a = 1
    private var b = 2
    #else
    public var c = 3
    private var d = 4
    #endif
  }
}
