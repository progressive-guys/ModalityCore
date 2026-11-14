// MARK: - Case ConstantGetsEmptyInitializer
// MARK: Input
import SwiftUI

struct InitializedConstant: View {
  let title = "value"
  var body: some View { Text(title) }
}

// MARK: Output
import SwiftUI

struct InitializedConstant: View {

  private let title = "value"

  init() {
  }

  var body: some View { Text(title) }
}

// MARK: - Case DefaultInputInitializer
// MARK: Input
import SwiftUI

struct Defaults: View {
  var value: Int = 1
  var body: some View { Text(String(value)) }
}

// MARK: Output
import SwiftUI

struct Defaults: View {

  private var value: Int

  init(value: Int = 1) {
    self.value = value
  }

  var body: some View { Text(String(value)) }
}

// MARK: - Case EscapingClosureInitializer
// MARK: Input
import SwiftUI

struct Content: View {
  let action: () -> Int
  var body: some View { Text(String(action())) }
}

@MainActor
func makeContent() -> Content { Content(action: { 3 }) }

// MARK: Output
import SwiftUI

struct Content: View {

  private let action: () -> Int

  init(action: @escaping () -> Int) {
    self.action = action
  }

  var body: some View { Text(String(action())) }
}

@MainActor
func makeContent() -> Content { Content(action: { 3 }) }

// MARK: - Case ExistingInitializer
// MARK: Input
import SwiftUI

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

// MARK: Output
import SwiftUI

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

// MARK: - Case GeneratedBindingInitializer
// MARK: Input
import SwiftUI

struct GeneratedInitializer: SwiftUI.View {
  let title: String
  @Binding var selected: Bool
  @Environment(\.colorScheme) private var colorScheme
  @State private var cached: Int?
  var body: some View { Text(title) }
}

// MARK: Output
import SwiftUI

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
