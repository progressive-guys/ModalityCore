import SwiftUI

public extension View {

  @ViewBuilder
  func onValueChange<Value: Equatable>(
    of value: Value,
    perform action: @escaping (Value) -> Void
  ) -> some View {
    if #available(macOS 14.0, iOS 17.0, *) {
      onChange(of: value) { _, newValue in
        action(newValue)
      }
    } else {
      onChange(of: value, perform: action)
    }
  }
}
