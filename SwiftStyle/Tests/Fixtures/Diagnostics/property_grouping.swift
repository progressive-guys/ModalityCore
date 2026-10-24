// MARK: - Accepted

public enum Accepted {

  @propertyWrapper
  struct F<T> {

    var wrappedValue: T
  }

  @propertyWrapper
  struct G<T> {

    var wrappedValue: T
  }

  open class ReadVisibilityOrder {
    open var a: Int { 1 }
    public var b = 2
    var c = 3
    private var d = 4
    fileprivate var e = 5
  }

  struct ReadVisibilityWithPrivateSetter {

    public private(set) var a = 1
    public var b = 2
    var c = 3
  }

  struct StaticLetVarThenWrappers {

    static let s = 0
    let a = 1
    var b = 2

    @Accepted.F var y = 3
  }

  struct SeparateSmallTypeGroups {

    var a: Int = 1
    var b = 2

    var c: String = "three"
    var d = "four"
  }

  struct SeparateLargeVisibilityGroups {

    public var a = 1
    public var b = 2
    public var c = 3

    private var d = 4
  }

  struct HeaderBetweenVisibilityGroups {

    public var a = 1
    public var b = 2
    public var c = 3

    // MARK: - Private values

    private var d = 4
    private var e = 5
  }

  struct SeparateStaticAndInstanceGroups {

    static let a = 1
    static let b = 2
    static let c = 3

    let d = 4
  }

  struct SeparateWrapperKinds {

    @Accepted.F var a: Int = 1

    @Accepted.G var b: Int = 2
  }

  struct ThreeLineGetterNextToMethod {

    var x: Int {
      1
    }

    func read() -> Int { x }
  }

  struct FourLineGetterWithBlankLines {

    func a() -> Int { 0 }

    var x: Int {
      let n = 1
      return n
    }

    func z() -> Int { x }
  }

  struct BlankLineBetweenAccessors {

    var a: Int {
      get { 1 }
      set {}
    }

    var b: Int {
      get { 2 }
      set {}
    }
  }

  /// A stored-property observer does not use the long computed-property spacing rule.
  struct StoredPropertyObserver {

    var x = 1 {
      didSet {
        _ = oldValue
      }
    }
    func read() -> Int { x }
  }

  struct IndependentConditionalBranches {

    #if os(macOS)
    public var a = 1
    private var b = 2
    #else
    public var c = 3
    private var d = 4
    #endif
  }

  struct MethodsEndPropertyGroups {

    var a = 1

    func readFirst() -> Int { a }

    var b = 2

    func readSecond() -> Int { b }

    var c = 3

    func readThird() -> Int { c }
  }

  /// This syntax-only rule leaves call result types to the compiler.
  struct UnknownCallResultTypes {

    static func f() -> Int { 1 }

    let a = f()
    let m = "value"
    let z = f()
  }

  struct DocCommentBelongsToProperty {

    var a = 1

    /// The second value.
    var b = 2
  }

  struct EquivalentArrayTypeSpellings {

    var a: [Int] = []
    var b: Array<Int> = []

    var m = "value"
  }

  struct SharedTypeAnnotation {

    var a, b: Int
    var c = 3

    var s = "value"
  }

  struct WrapperArgumentsKeepOneGroup {

    @Accepted.F(wrappedValue: 1) var a: Int
    @Accepted.F(wrappedValue: 2) var b: Int
  }

  struct HeaderKeepsPropertiesTogether {

    // Input values.
    var a = 1
    var b = 2
  }

  struct OptionSetLiteralKeepsDeclaredType: OptionSet {

    static let a = OptionSetLiteralKeepsDeclaredType(rawValue: 1)
    static let b = OptionSetLiteralKeepsDeclaredType(rawValue: 2)
    static let c: OptionSetLiteralKeepsDeclaredType = [.a, .b]

    let rawValue: Int
  }

  struct MultipleBindingsFormLargeGroup {

    static let a = 1, b = 2, c = 3

    let d = 4
  }
}

// MARK: - Rejected

public enum Rejected {

  struct PublicAfterPrivate {

    private var a = 1
    public var b = 2
  }

  struct PublicAfterPrivateAcrossMethod {

    private var a = 1

    // Comment
    func function() {}

    public var b = 2
  }

  struct PrivateAfterFileprivate {

    fileprivate var a = 1
    private var b = 2
  }

  struct StaticAfterInstance {

    let a = 1
    static let b = 2
  }

  struct LetAfterVar {

    var a = 1
    let b = 2
  }

  struct PlainPropertyAfterWrapper {

    @Accepted.F var a: Int = 1

    var b = 2
  }

  struct RepeatedExplicitTypeGroup {

    var a: Int = 1

    var m: String = "value"

    var z: Int = 2
  }

  struct RepeatedInferredTypeGroup {

    var a = 1

    var m = "value"

    var z = -2
  }

  struct RepeatedConstructorTypeGroup {

    let a = String("one")

    let m = 1

    let z = String("two")
  }

  struct RepeatedWrapperGroup {

    @Accepted.F var a: Int = 1

    @Accepted.G var m: Int = 2

    @Accepted.F var z: Int = 3
  }

  struct MissingVisibilityGroupGap {

    public var a = 1
    public var b = 2
    public var c = 3
    private var d = 4
  }

  struct MissingStaticGroupGap {

    static let a = 1
    static let b = 2
    static let c = 3
    let d = 4
  }

  struct BlankLineWithinSameType {

    var a = 1

    var b = 2
  }

  struct MissingGapBeforeLongGetter {

    func read() -> Int { 0 }
    var x: Int {
      let n = 1
      return n
    }
  }

  struct MissingGapAfterLongGetter {

    var x: Int {
      let n = 1
      return n
    }
    func read() -> Int { x }
  }

  struct MissingGapBetweenAccessors {

    var a: Int {
      get { 1 }
      set {}
    }
    var b: Int {
      get { 2 }
      set {}
    }
  }

  struct ExtraGapBetweenAccessors {

    var a: Int {
      get { 1 }
      set {}
    }


    var b: Int {
      get { 2 }
      set {}
    }
  }

  struct MultipleBindingsCountTowardGroupSize {

    static let a = 1, b = 2, c = 3
    let d = 4
  }

  struct WrongVisibilityInConditionalBranch {

    #if os(macOS)
    private var a = 1
    public var b = 2
    #endif
  }

  struct RepeatedSharedTypeGroup {

    var a, b: Int

    var s = "value"

    var z = 3
  }

  struct RepeatedArrayTypeGroup {

    var a: [Int] = []

    var s = "value"

    var z: Array<Int> = []
  }

  struct MissingGapBetweenTwoTypes {

    var w: Double = 1
    var s: String = "value"
  }

  struct MissingGapBetweenTwoWrappers {

    @Accepted.F var a: Int = 1
    @Accepted.G var b: Int = 2
  }

  struct BlankLineAfterGroupHeader {

    // Input values.
    var a = 1

    var b = 2
  }
}

// MARK: - Accepted

public extension Accepted.ReadVisibilityOrder {

  var a1: Int { 1 }
  internal var b1: Int { 2 }
}
