#if os(macOS)
import AppKit
import Testing
import SwiftUI
import ModalityDesign

struct OnValueChangeTests {

  @Test
  @MainActor
  func reportsOnlyChangedValues() {
    let initialValue = "initial"
    let changedValue = "changed"
    var receivedValues: [String] = []
    let recordValue: (String) -> Void = { receivedValues.append($0) }
    let host = NSHostingView(rootView: Color.clear.onValueChange(of: initialValue, perform: recordValue))
    host.layoutSubtreeIfNeeded()

    #expect(receivedValues.isEmpty)

    host.rootView = Color.clear.onValueChange(of: changedValue, perform: recordValue)
    host.layoutSubtreeIfNeeded()

    #expect(receivedValues == [changedValue])

    host.rootView = Color.clear.onValueChange(of: changedValue, perform: recordValue)
    host.layoutSubtreeIfNeeded()

    #expect(receivedValues == [changedValue])
  }
}
#endif
