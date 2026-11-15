// MARK: - Условное объявление вложенного типа перед хранимыми свойствами
struct Values {

  var stored = 0
  #if MEMBER_BRANCH
  struct Nested {}
  #else
  struct Nested {}
  #endif
}

/// Output
struct Values {

  #if MEMBER_BRANCH
  struct Nested {}
  #else
  struct Nested {}
  #endif

  var stored = 0
}

// MARK: - Условное объявление индексатора перед функцией
struct FunctionBeforeConditionalSubscript {
  func read() {}
  #if MEMBER_BRANCH
  subscript(index: Int) -> Int { index }
  #else
  subscript(index: Int) -> Int { index + 1 }
  #endif
}

/// Output
struct FunctionBeforeConditionalSubscript {

  #if MEMBER_BRANCH
  subscript(index: Int) -> Int { index }
  #else
  subscript(index: Int) -> Int { index + 1 }
  #endif
  func read() {}
}

// MARK: - Независимая сортировка веток условной компиляции
struct ConditionalBranch {
  #if MEMBER_BRANCH
  func read() -> Int { value }
  var value: Int { 1 }
  #else
  func read() -> Int { value }
  var value: Int { 2 }
  #endif
}

/// Output
struct ConditionalBranch {

  #if MEMBER_BRANCH
  var value: Int { 1 }

  func read() -> Int { value }
  #else
  var value: Int { 2 }

  func read() -> Int { value }
  #endif
}

// MARK: - Условные вычисляемые свойства перемещаются перед функцией
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

/// Output
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

// MARK: - Хранимое свойство перемещается перед init и условными вычисляемыми свойствами
struct StoredAfterConditionalGetter {
  init() {}
  #if MEMBER_BRANCH
  var displayed: Int { 1 }
  #else
  var displayed: String { "value" }
  #endif
  var isImporting = false
}

/// Output
struct StoredAfterConditionalGetter {

  var isImporting = false

  init() {}
  #if MEMBER_BRANCH
  var displayed: Int { 1 }
  #else
  var displayed: String { "value" }
  #endif
}

// MARK: - Свойство с обёрткой перед блоком условной компиляции

struct Content: View {

  #if os(macOS)
  @ViewBuilder private var content: some View { Text("Desktop") }
  #else
  private var content: some View { EmptyView() }
  #endif
  @State private var importing = false

  var body: some View { content }
}

/// Output

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
