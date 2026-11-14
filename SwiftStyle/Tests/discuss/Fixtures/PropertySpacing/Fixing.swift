// MARK: - Case AfterMultilineGetter
// MARK: Input
struct MissingGapAfterLongGetter {

  var x: Int {
    let n = 1
    return n
  }
  func read() -> Int { x }
}

// MARK: Output
struct MissingGapAfterLongGetter {

  var x: Int {
    let n = 1
    return n
  }

  func read() -> Int { x }
}

// MARK: - Case BetweenMultilineAccessors
// MARK: Input
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

// MARK: Output
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

// MARK: - Case CommentAfterBindingBoundary
// MARK: Input
struct MissingBindingGapBeforeComment {
  let a = 1
  // Mutable value.
  var b = 2
}

// MARK: Output
struct MissingBindingGapBeforeComment {
  let a = 1

  // Mutable value.
  var b = 2
}

// MARK: - Case CompactAfterGroupHeader
// MARK: Input
struct BlankLineAfterGroupHeader {

  // Input values.
  var a = 1

  var b = 2
}

// MARK: Output
struct BlankLineAfterGroupHeader {
  // Input values.
  var a = 1
  var b = 2
}

// MARK: - Case CompactComputedPair
// MARK: Input
struct ExtraComputedGap {
  var a: Int { 1 }

  var b: Int { 2 }
}

// MARK: Output
struct ExtraComputedGap {
  var a: Int { 1 }
  var b: Int { 2 }
}

// MARK: - Case CompactDifferentTypePair
// MARK: Input
struct ExtraGapBetweenTwoTypes {

  var w: Double = 1

  var s: String = "value"
}

// MARK: Output
struct ExtraGapBetweenTwoTypes {
  var w: Double = 1
  var s: String = "value"
}

// MARK: - Case CompactDifferentWrapperPair
// MARK: Input
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }

  @propertyWrapper
  struct G<Value> {
    var wrappedValue: Value
  }
}

struct ExtraGapBetweenTwoWrappers {

  @Wrappers.F var a: Int = 1

  @Wrappers.G var b: Int = 2
}

// MARK: Output
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }

  @propertyWrapper
  struct G<Value> {
    var wrappedValue: Value
  }
}

struct ExtraGapBetweenTwoWrappers {
  @Wrappers.F var a: Int = 1
  @Wrappers.G var b: Int = 2
}

// MARK: - Case CompactRequirementKinds
// MARK: Input
protocol Values {
  var a: Int { get }

  var b: Int { get set }
}

// MARK: Output
protocol Values {
  var a: Int { get }
  var b: Int { get set }
}

// MARK: - Case CompactSameTypePair
// MARK: Input
struct BlankLineWithinSameType {

  var a = 1

  var b = 2
}

// MARK: Output
struct BlankLineWithinSameType {
  var a = 1
  var b = 2
}

// MARK: - Case ExcessBetweenAccessors
// MARK: Input
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

// MARK: Output
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

// MARK: - Case ExcessBindingGap
// MARK: Input
struct ExtraBindingGap {
  let a = 1


  var b = 2
}

// MARK: Output
struct ExtraBindingGap {
  let a = 1

  var b = 2
}

// MARK: - Case LetVarBoundary
// MARK: Input
struct MissingSmallBindingGap {
  let a = 1
  var b = 2
}

// MARK: Output
struct MissingSmallBindingGap {
  let a = 1

  var b = 2
}

// MARK: - Case LetWrappedVarBoundary
// MARK: Input
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }
}

struct MissingWrapperBindingGap {
  let a = 1
  @Wrappers.F var b = 2
}

// MARK: Output
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }
}

struct MissingWrapperBindingGap {
  let a = 1

  @Wrappers.F var b = 2
}

// MARK: - Case MultilineLiteralGetter
// MARK: Input
class Computed {
  var longerName: Int { 1 }
  var x: Int {
    1000000000000000
  }
}

// MARK: Output
class Computed {

  var longerName: Int { 1 }

  var x: Int {
    1000000000000000
  }
}
