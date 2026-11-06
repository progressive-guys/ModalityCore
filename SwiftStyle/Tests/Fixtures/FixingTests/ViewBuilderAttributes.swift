// MARK: - Input
import SwiftUI

struct Example {
  @MainActor @ViewBuilder var rootView: some View {
    Text("Example")
  }
}

// MARK: - Output
import SwiftUI

struct Example {

  @MainActor
  @ViewBuilder
  var rootView: some View {
    Text("Example")
  }
}
