// MARK: - Case ArrayTypeSpellings
struct EquivalentArrayTypeSpellings {

  var a: [Int]
  var m : String
  var b: Array<Int>

  init(a: [Int] = [], b: Array<Int> = [], m: String = "value") {
    self.a = a
    self.b = b
    self.m = m
  }
}

// MARK: - Case ComputedCommentGroups
public enum Examples {

  struct ComputedCommentGroups {

    private var longerName: Int { 1 }
    var second: Int { 2 }
    var third: Int { 3 }
    var fourth: Int { 4 }
    public static var flag: Bool { true }

    // Display values.
    var title: String { "value" }
    var x: Int { 0 }
  }
}

// MARK: - Case EffectiveExtensionAccess
public enum Examples {}

public extension Examples {

  var a1: Int { 1 }
  internal var b1: Int { 2 }
}

// MARK: - Case LargeGroupHasBothSeparators
struct LargeGroupHasBothSeparators {

  let value = 0

  var a = 1
  var b = 2
  var c = 3
  var d = 4

  private var hidden = 5
}

// MARK: - Case MarkHeaderPreserved
struct HeaderBetweenVisibilityGroups {

  public var a = 1
  public var b = 2
  public var c = 3
  public var cc = 4

  // MARK: - Private values

  private var d = 4
  private var e = 5
}

// MARK: - Case ReadAccessAndPrivateSetter
struct ReadVisibilityWithPrivateSetter {

  public var b : Int

  public private(set) var a : Int
  var c : Int

  init(a: Int = 1, b: Int = 2, c: Int = 3) {
    self.a = a
    self.b = b
    self.c = c
  }
}

// MARK: - Case ReadVisibilityOrder
open class ReadVisibilityOrder {

  public var b = 2
  var c = 3
  private var d = 4
  fileprivate var e = 5

  open var a: Int { 1 }
}

// MARK: - Case SharedTypeAnnotationAccepted
struct SharedTypeAnnotation {

  var c = 3
  var a, b: Int
  var s = "value"
}

// MARK: - Case StaticCrossReferences
struct OptionSetLiteralKeepsDeclaredType: OptionSet {

  static let c: OptionSetLiteralKeepsDeclaredType = [.a, .b]
  static let a = OptionSetLiteralKeepsDeclaredType(rawValue: 1)
  static let b = OptionSetLiteralKeepsDeclaredType(rawValue: 2)
  let rawValue: Int

  init(rawValue: Int) {
    self.rawValue = rawValue
  }
}

// MARK: - Case ThreeStaticMembers
struct ThreeElementsStayTogether {

  static let a = 1
  static let b = 2
  static let c = 3
  let value = 4
}

// MARK: - Case UnknownCallResultType
private func makeNumber() -> Int { 1 }

struct Values {

  let a = makeNumber()
  let z = makeNumber()
  let m = "value"
}

// MARK: - Case WrapperArgumentsShareIdentity
@propertyWrapper
struct Wrapped<Value> {
  var wrappedValue: Value
}

struct Values {

  @Wrapped(wrappedValue: 1) var a: Int
  @Wrapped(wrappedValue: 2) var b: Int
}
