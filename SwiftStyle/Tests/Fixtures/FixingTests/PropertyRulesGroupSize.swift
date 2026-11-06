// MARK: - Input
public enum Examples {

  struct MissingVisibilityGroupGap {

    public var a = 1
    public var b = 2
    public var c = 3
    public var cc = 4
    private var d = 4
  }

  struct MissingStaticGroupGap {

    static let a = 1
    static let b = 2
    static let c = 3
    static let cc = 4
    let d = 4
  }

  struct MultipleBindingsCountTowardGroupSize {

    static let a = 1, b = 2, c = 3, cc = 4
    let d = 4
  }
}

// MARK: - Output
public enum Examples {

  struct MissingVisibilityGroupGap {

    public var a = 1
    public var b = 2
    public var c = 3
    public var cc = 4

    private var d = 4
  }

  struct MissingStaticGroupGap {

    static let a = 1
    static let b = 2
    static let c = 3
    static let cc = 4

    let d = 4
  }

  struct MultipleBindingsCountTowardGroupSize {
    static let a = 1, b = 2, c = 3, cc = 4

    let d = 4
  }
}
