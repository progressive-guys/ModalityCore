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

  struct ExtraComputedGap {
    var a: Int { 1 }

    var b: Int { 2 }
  }

  struct ExtraRequirementGap {
    protocol Requirements {
      var a: Int { get }

      var b: Int { get set }
    }
  }

  struct BlankLineWithinSameType {

    var a = 1

    var b = 2
  }

  struct ExtraGapBetweenTwoTypes {

    var w: Double = 1

    var s: String = "value"
  }

  struct ExtraGapBetweenTwoWrappers {

    @Wrappers.F var a: Int = 1

    @Wrappers.G var b: Int = 2
  }

  struct BlankLineAfterGroupHeader {

    // Input values.
    var a = 1

    var b = 2
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

  struct ExtraComputedGap {
    var a: Int { 1 }
    var b: Int { 2 }
  }

  struct ExtraRequirementGap {

    protocol Requirements {
      var a: Int { get }
      var b: Int { get set }
    }
  }

  struct BlankLineWithinSameType {
    var a = 1
    var b = 2
  }

  struct ExtraGapBetweenTwoTypes {
    var w: Double = 1
    var s: String = "value"
  }

  struct ExtraGapBetweenTwoWrappers {
    @Wrappers.F var a: Int = 1
    @Wrappers.G var b: Int = 2
  }

  struct BlankLineAfterGroupHeader {
    // Input values.
    var a = 1
    var b = 2
  }
}
