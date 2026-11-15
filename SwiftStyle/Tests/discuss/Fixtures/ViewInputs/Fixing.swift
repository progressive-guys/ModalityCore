// MARK: - Свойство View становится private; добавляется пустой инициализатор

struct InitializedConstant: View {
  let title = "value"
  var body: some View { Text(title) }
}

/// Output

struct InitializedConstant: View {

  private let title = "value"

  init() {
  }

  var body: some View { Text(title) }
}

// MARK: - Свойство View становится private; значение по умолчанию переносится в инициализатор

struct Defaults: View {
  var value: Int = 1
  var body: some View { Text(String(value)) }
}

/// Output

struct Defaults: View {

  private var value: Int

  init(value: Int = 1) {
    self.value = value
  }

  var body: some View { Text(String(value)) }
}

// MARK: - Свойство-замыкание View становится private; добавляется инициализатор с escaping

struct Content: View {
  let action: () -> Int
  var body: some View { Text(String(action())) }
}

@MainActor
func makeContent() -> Content { Content(action: { 3 }) }

/// Output

struct Content: View {

  private let action: () -> Int

  init(action: @escaping () -> Int) {
    self.action = action
  }

  var body: some View { Text(String(action())) }
}

@MainActor
func makeContent() -> Content { Content(action: { 3 }) }

// MARK: - Свойства View становятся private; существующий инициализатор сохраняется

struct ExplicitInitializer: View {
  let title: String
  @Binding var selected: Bool
  var subtitle: String { title }
  var body: some View { Text(title) }

  init(title: String, selected: Binding<Bool>) {
    self.title = title
    self._selected = selected
  }
}

/// Output

struct ExplicitInitializer: View {

  private let title: String

  @Binding private var selected: Bool

  init(title: String, selected: Binding<Bool>) {
    self.title = title
    self._selected = selected
  }

  private var subtitle: String { title }
  var body: some View { Text(title) }
}

// MARK: - Входы View становятся private; инициализатор принимает Binding и сохраняет Environment и State

struct GeneratedInitializer: SwiftUI.View {
  let title: String
  @Binding var selected: Bool
  @Environment(\.colorScheme) private var colorScheme
  @State private var cached: Int?
  var body: some View { Text(title) }
}

/// Output

struct GeneratedInitializer: SwiftUI.View {

  private let title: String

  @Binding private var selected: Bool
  @Environment(\.colorScheme) private var colorScheme
  @State private var cached: Int?

  init(title: String, selected: Binding<Bool>) {
    self.title = title
    self._selected = selected
  }

  var body: some View { Text(title) }
}
