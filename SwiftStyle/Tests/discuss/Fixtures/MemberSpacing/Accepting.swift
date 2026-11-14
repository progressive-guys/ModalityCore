// MARK: - Case BeforeMultilineFunction
struct Methods {

  func a() -> Int { 1 }
  func b() -> Int { 2 }

  func c() -> Int {
    3
  }
}

// MARK: - Case DifferentMemberKinds
struct DifferentKinds {
  var a = 1

  init() {}

  func read() -> Int { a }
}

// MARK: - Case InlineNestedTypes
struct SeparatedTypes {
  struct First {}

  struct Second {}
}

// MARK: - Case MultilineTypeAlias
typealias Name = String

typealias Entry = (
  Name,
  Int
)

typealias Entries = [Entry]

// MARK: - Case ProtocolKindGroups
protocol Worker {

  associatedtype Value

  init()

  subscript(index: Int) -> Value { get }

  var current: Value { get }

  func start()
}
