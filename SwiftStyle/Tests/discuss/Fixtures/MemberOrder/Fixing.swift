// MARK: - Case AliasBeforeAssociatedType
// MARK: Input
protocol Requirements {
  associatedtype Value
  typealias Number = Int
}

// MARK: Output
protocol Requirements {

  typealias Number = Int

  associatedtype Value
}

// MARK: - Case AliasBeforeStorage
// MARK: Input
struct AliasAfterStorage {
  var value = 0
  typealias Value = Int
}

// MARK: Output
struct AliasAfterStorage {

  typealias Value = Int

  var value = 0
}

// MARK: - Case AssociatedTypeBeforeSubscript
// MARK: Input
protocol Requirements {
  subscript(index: Int) -> Int { get }
  associatedtype Value
}

// MARK: Output
protocol Requirements {

  associatedtype Value

  subscript(index: Int) -> Int { get }
}

// MARK: - Case ComputedBeforeFunction
// MARK: Input
struct FunctionBeforeComputed {
  func read() -> Int { value }
  var value: Int { 1 }
}

// MARK: Output
struct FunctionBeforeComputed {

  var value: Int { 1 }

  func read() -> Int { value }
}

// MARK: - Case DeinitializerBeforeSubscript
// MARK: Input
final class SubscriptBeforeDeinit {
  subscript(index: Int) -> Int { index }
  deinit {}
}

// MARK: Output
final class SubscriptBeforeDeinit {

  deinit {}

  subscript(index: Int) -> Int { index }
}

// MARK: - Case InitializerBeforeComputed
// MARK: Input
struct ComputedBeforeInitializer {
  var value: Int { 1 }
  init() {}
}

// MARK: Output
struct ComputedBeforeInitializer {

  init() {}

  var value: Int { 1 }
}

// MARK: - Case InitializerBeforeDeinitializer
// MARK: Input
final class DeinitBeforeInit {
  deinit {}
  init() {}
}

// MARK: Output
final class DeinitBeforeInit {

  init() {}

  deinit {}
}

// MARK: - Case InitializerBeforeSubscriptRequirement
// MARK: Input
protocol Values {
  subscript(index: Int) -> Int { get }
  init()
}

// MARK: Output
protocol Values {

  init()

  subscript(index: Int) -> Int { get }
}

// MARK: - Case LeadingCommentMovesWithComputed
// MARK: Input
struct Values {

  func read() -> Int { value }
  // Display value.
  var value: Int { 1 }
}

// MARK: Output
struct Values {

  // Display value.
  var value: Int { 1 }

  func read() -> Int { value }
}

// MARK: - Case NestedTypeBeforeFunction
// MARK: Input
struct TypeAfterFunction {
  func read() {}
  struct Value {}
}

// MARK: Output
struct TypeAfterFunction {

  struct Value {}

  func read() {}
}

// MARK: - Case NestedTypeBeforeStorage
// MARK: Input
struct Values {
  var stored = 0
  struct Nested {}
}

// MARK: Output
struct Values {

  struct Nested {}

  var stored = 0
}

// MARK: - Case NestedTypeInExtension
// MARK: Input
struct Value {}

extension Value {
  func read() {}
  struct Nested {}
}

// MARK: Output
struct Value {}

extension Value {

  struct Nested {}

  func read() {}
}

// MARK: - Case ObserverBeforeInitializer
// MARK: Input
struct ObserverIsStored {
  init() {}
  var value = 0 { didSet {} }
}

// MARK: Output
struct ObserverIsStored {

  var value = 0 { didSet {} }

  init() {}
}

// MARK: - Case PropertyBeforeMethodRequirement
// MARK: Input
protocol Values {
  func read()
  var value: Int { get }
}

// MARK: Output
protocol Values {

  var value: Int { get }

  func read()
}

// MARK: - Case StorageBeforeInitializer
// MARK: Input
struct InitializerBeforeStorage {
  init() {}
  var value = 1
}

// MARK: Output
struct InitializerBeforeStorage {

  var value = 1

  init() {}
}

// MARK: - Case SubscriptBeforeComputed
// MARK: Input
struct ComputedBeforeSubscript {
  var value: Int { 1 }
  subscript(index: Int) -> Int { index }
}

// MARK: Output
struct ComputedBeforeSubscript {

  subscript(index: Int) -> Int { index }

  var value: Int { 1 }
}

// MARK: - Case SubscriptBeforePropertyRequirement
// MARK: Input
protocol Values {
  var value: Int { get }
  subscript(index: Int) -> Int { get }
}

// MARK: Output
protocol Values {

  subscript(index: Int) -> Int { get }

  var value: Int { get }
}
