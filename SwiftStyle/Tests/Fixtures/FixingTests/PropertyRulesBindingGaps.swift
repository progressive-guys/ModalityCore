// MARK: - Input
public enum Wrappers {

  @propertyWrapper
  struct F<T> {

    var wrappedValue: T
  }
}

public enum Examples {

  struct MissingSmallBindingGap {
    let a = 1
    var b = 2
  }

  @MainActor
  struct MissingStaticBindingGap {
    static let a = 1
    static var b = 2
  }

  struct MissingWrapperBindingGap {
    let a = 1
    @Wrappers.F var b = 2
  }

  struct MissingBindingGapBeforeComment {
    let a = 1
    // Mutable value.
    var b = 2
  }

  struct ExtraBindingGap {
    let a = 1


    var b = 2
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

  struct MissingSmallBindingGap {
    let a = 1

    var b = 2
  }

  @MainActor
  struct MissingStaticBindingGap {
    static let a = 1

    static var b = 2
  }

  struct MissingWrapperBindingGap {
    let a = 1

    @Wrappers.F var b = 2
  }

  struct MissingBindingGapBeforeComment {
    let a = 1

    // Mutable value.
    var b = 2
  }

  struct ExtraBindingGap {
    let a = 1

    var b = 2
  }
}
