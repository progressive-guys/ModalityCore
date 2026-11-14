// MARK: - Case ConditionalNestedTypeBeforeStorage
// MARK: Input
struct Values {

  var stored = 0
  #if MEMBER_BRANCH
  struct Nested {}
  #else
  struct Nested {}
  #endif
}

// MARK: Output
struct Values {

  #if MEMBER_BRANCH
  struct Nested {}
  #else
  struct Nested {}
  #endif

  var stored = 0
}

// MARK: - Case ConditionalSubscriptBeforeFunction
// MARK: Input
struct FunctionBeforeConditionalSubscript {
  func read() {}
  #if MEMBER_BRANCH
  subscript(index: Int) -> Int { index }
  #else
  subscript(index: Int) -> Int { index + 1 }
  #endif
}

// MARK: Output
struct FunctionBeforeConditionalSubscript {

  #if MEMBER_BRANCH
  subscript(index: Int) -> Int { index }
  #else
  subscript(index: Int) -> Int { index + 1 }
  #endif
  func read() {}
}

// MARK: - Case IndependentBranches
// MARK: Input
struct ConditionalBranch {
  #if MEMBER_BRANCH
  func read() -> Int { value }
  var value: Int { 1 }
  #else
  func read() -> Int { value }
  var value: Int { 2 }
  #endif
}

// MARK: Output
struct ConditionalBranch {

  #if MEMBER_BRANCH
  var value: Int { 1 }

  func read() -> Int { value }
  #else
  var value: Int { 2 }

  func read() -> Int { value }
  #endif
}

// MARK: - Case NestedConditionalGetterBeforeFunction
// MARK: Input
struct FunctionBeforeConditionalGetter {
  func read() -> Int { 0 }
  #if MEMBER_BRANCH
  #if DEBUG
  var displayed: Int { 1 }
  #else
  var displayed: Int { 2 }
  #endif
  #endif
}

// MARK: Output
struct FunctionBeforeConditionalGetter {

  #if MEMBER_BRANCH
  #if DEBUG
  var displayed: Int { 1 }
  #else
  var displayed: Int { 2 }
  #endif
  #endif
  func read() -> Int { 0 }
}

// MARK: - Case StorageBeforeConditionalGetter
// MARK: Input
struct StoredAfterConditionalGetter {
  init() {}
  #if MEMBER_BRANCH
  var displayed: Int { 1 }
  #else
  var displayed: String { "value" }
  #endif
  var isImporting = false
}

// MARK: Output
struct StoredAfterConditionalGetter {

  var isImporting = false

  init() {}
  #if MEMBER_BRANCH
  var displayed: Int { 1 }
  #else
  var displayed: String { "value" }
  #endif
}

// MARK: - Case WrappedStorageBeforeRegion
// MARK: Input
import SwiftUI

struct Content: View {

  #if os(macOS)
  @ViewBuilder private var content: some View { Text("Desktop") }
  #else
  private var content: some View { EmptyView() }
  #endif
  @State private var importing = false

  var body: some View { content }
}

// MARK: Output
import SwiftUI

struct Content: View {

  @State private var importing = false

  #if os(macOS)
  @ViewBuilder
  private var content: some View { Text("Desktop") }
  #else
  private var content: some View { EmptyView() }
  #endif

  var body: some View { content }
}
