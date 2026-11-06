// MARK: - Input
public enum Examples {

  struct WrongVisibilityInConditionalBranch {

    #if os(macOS)
    private var a = 1
    public var b = 2
    #endif
  }
}

// MARK: - Output
public enum Examples {

  struct WrongVisibilityInConditionalBranch {

    #if os(macOS)
    public var b = 2
    private var a = 1
    #endif
  }
}
