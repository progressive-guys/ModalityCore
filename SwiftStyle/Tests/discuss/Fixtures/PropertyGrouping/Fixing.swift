// MARK: - Case ConditionalVisibilityBranch
// MARK: Input
public enum Examples {

  struct WrongVisibilityInConditionalBranch {

    #if PROPERTY_BRANCH
    private var a = 1
    public var b = 2
    #endif
  }
}

// MARK: Output
public enum Examples {

  struct WrongVisibilityInConditionalBranch {

    #if PROPERTY_BRANCH
    public var b = 2
    private var a = 1
    #endif
  }
}

// MARK: - Case ConstructorResultType
// MARK: Input
struct RepeatedConstructorTypeGroup {
  let a = String("one")
  let m = 1
  let z = String("two")
}

// MARK: Output
struct RepeatedConstructorTypeGroup {
  let m = 1
  let a = String("one")
  let z = String("two")
}

// MARK: - Case FourBindingsOneDeclaration
// MARK: Input
struct MultipleBindingsCountTowardGroupSize {

  static let a = 1, b = 2, c = 3, cc = 4
  let d = 4
}

// MARK: Output
struct MultipleBindingsCountTowardGroupSize {
  static let a = 1, b = 2, c = 3, cc = 4

  let d = 4
}

// MARK: - Case FourStaticMembers
// MARK: Input
struct MissingStaticGroupGap {

  static let a = 1
  static let b = 2
  static let c = 3
  static let cc = 4
  let d = 4
}

// MARK: Output
struct MissingStaticGroupGap {

  static let a = 1
  static let b = 2
  static let c = 3
  static let cc = 4

  let d = 4
}

// MARK: - Case FourVisibilityMembers
// MARK: Input
struct MissingVisibilityGroupGap {

  public var a = 1
  public var b = 2
  public var c = 3
  public var cc = 4
  private var d = 4
}

// MARK: Output
struct MissingVisibilityGroupGap {

  public var a = 1
  public var b = 2
  public var c = 3
  public var cc = 4

  private var d = 4
}

// MARK: - Case LetBeforeVar
// MARK: Input
final class Values {
  var a = 1
  let b = 2
}

// MARK: Output
final class Values {
  let b = 2

  var a = 1
}

// MARK: - Case PlainBeforeWrappedStorage
// MARK: Input
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }
}

final class Values {
  @Wrappers.F var a: Int = 1
  var b = 2
}

// MARK: Output
enum Wrappers {

  @propertyWrapper
  struct F<Value> {
    var wrappedValue: Value
  }
}

final class Values {
  var b = 2
  @Wrappers.F var a: Int = 1
}

// MARK: - Case PrivateBeforeFileprivate
// MARK: Input
final class Values {
  fileprivate var a = 1
  private var b = 2
}

// MARK: Output
final class Values {
  private var b = 2
  fileprivate var a = 1
}

// MARK: - Case PublicBeforePrivate
// MARK: Input
final class Values {
  private var a = 1
  public var b = 2
}

// MARK: Output
final class Values {
  public var b = 2
  private var a = 1
}

// MARK: - Case PublishedPrivateSetter
// MARK: Input

final class Model {

  @Published private(set) var value = 0
  @Published var isReady = false
}

// MARK: Output

final class Model {
  @Published var isReady = false

  @Published private(set) var value = 0
}

// MARK: - Case RepeatedExplicitType
// MARK: Input
final class Values {
  var a: Int = 1
  var m: String = "value"
  var z: Int = 2
}

// MARK: Output
final class Values {
  var a: Int = 1
  var z: Int = 2
  var m: String = "value"
}

// MARK: - Case RepeatedLiteralType
// MARK: Input
final class Values {
  var a = 1
  var m = "value"
  var z = -2
}

// MARK: Output
final class Values {
  var a = 1
  var z = -2
  var m = "value"
}

// MARK: - Case RepeatedWrapperIdentity
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

struct RepeatedWrapperGroup {
  @Wrappers.F var a: Int = 1
  @Wrappers.G var m: Int = 2
  @Wrappers.F var z: Int = 3

  init() {}
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

struct RepeatedWrapperGroup {

  @Wrappers.F var a: Int = 1
  @Wrappers.F var z: Int = 3
  @Wrappers.G var m: Int = 2

  init() {}
}

// MARK: - Case SharedTypeBindingGroup
// MARK: Input
struct RepeatedSharedTypeGroup {
  var a, b: Int
  var s = "value"
  var z = 3

  init(a: Int, b: Int) {
    self.a = a
    self.b = b
  }
}

// MARK: Output
struct RepeatedSharedTypeGroup {

  var z = 3
  var a, b: Int
  var s = "value"

  init(a: Int, b: Int) {
    self.a = a
    self.b = b
  }
}

// MARK: - Case StaticBeforeInstance
// MARK: Input
final class Values {
  let a = 1
  static let b = 2
}

// MARK: Output
final class Values {
  static let b = 2
  let a = 1
}
