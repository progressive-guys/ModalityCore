// MARK: - Input
import SwiftUI

enum Examples {

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

  struct GeneratedInitializer: SwiftUI.View {
    let title: String
    @Binding var selected: Bool
    @Environment(\.colorScheme) private var colorScheme
    @State private var cached: Int?
    var body: some View { Text(title) }
  }

  struct InitializedConstant: View {
    let title = "value"
    var body: some View { Text(title) }
  }

  struct Defaults: View {
    var value: Int = 1
    var body: some View { Text(String(value)) }
  }
}

// MARK: - Output
import SwiftUI

enum Examples {

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

  struct InitializedConstant: View {

    private let title = "value"

    init() {
    }

    var body: some View { Text(title) }
  }

  struct Defaults: View {

    private var value: Int 

    init(value: Int = 1) {
      self.value = value
    }

    var body: some View { Text(String(value)) }
  }
}
