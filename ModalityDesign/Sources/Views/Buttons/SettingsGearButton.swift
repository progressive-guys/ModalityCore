import SwiftUI

public struct SettingsGearButton<Label: View, SettingsView: View>: View {

  @ViewBuilder private let label: () -> Label
  @ViewBuilder private let settingsView: () -> SettingsView

  @Environment(\.dismiss) private var dismiss
  @State private var isSettingsPresented: Bool = false

  public init(
    @ViewBuilder label: @escaping () -> Label = {
      Image(systemName: "gear")
        .resizable()
        .frame(width: 24, height: 24)
        .padding(16)
    },
    @ViewBuilder settingsView: @escaping () -> SettingsView
  ) {
    self.label = label
    self.settingsView = settingsView
  }

  public var body: some View {
    Group {
      #if os(macOS)
      if #available(macOS 14.0, *) {
        SettingsLink(label: label)
      } else {
        Button(
          action: {
            if Selector(("showSettingsWindow:")).sendToApp() { return }
            if Selector(("showPreferencesWindow:")).sendToApp() { return }
          },
          label: label
        )
      }
      #else
      Button(
        action: { isSettingsPresented = true },
        label: label
      )
      .sheet(isPresented: $isSettingsPresented) {
        settingsView()
      }
      #endif
    }
    .buttonStyle(.plain)
  }
}
