import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

public struct SegmentedControl<Option: Hashable & Identifiable>: View {

  private let options: [Option]
  private let selectionColor: Color
  private let backgroundColor: Color
  private let label: KeyPath<Option, String>

  @Binding private var selection: Option

  public init(
    selection: Binding<Option>,
    options: [Option],
    label: KeyPath<Option, String>,
    selectionColor: Color,
    backgroundColor: Color? = nil
  ) {
    self._selection = selection
    self.options = options
    self.label = label
    self.selectionColor = selectionColor
    self.backgroundColor = backgroundColor ?? selectionColor.opacity(0.5)
  }

  public var body: some View {
    #if os(iOS) || os(visionOS)
    if #available(iOS 26, visionOS 26, *) {
      Picker("", selection: $selection) {
        ForEach(options) { option in
          Text(option[keyPath: label])
            .font(.system(size: 5, weight: .semibold, design: .rounded))
            .tag(option)
        }
      }
      .pickerStyle(.segmented)
      .onAppear {
        UISegmentedControl.appearance()
          .setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: SegmentButton.segmentLabelFontSize, weight: .semibold)],
            for: .normal
          )

        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(selectionColor)
        UISegmentedControl.appearance().backgroundColor = UIColor(backgroundColor)
      }
    } else {
      legacy
    }
    #else
    legacy
    #endif
  }

  private var legacy: some View {
    LegacySegmentedControl(
      selection: $selection,
      options: options,
      label: label,
      selectionColor: selectionColor,
      backgroundColor: backgroundColor
    )
  }
}

private struct LegacySegmentedControl<Option: Hashable & Identifiable>: View {

  private let options: [Option]
  private let selectionColor: Color
  private let backgroundColor: Color
  private let label: KeyPath<Option, String>
  private let animation: Animation = .bouncy
  private let interSegmentSpacing: CGFloat = 2
  private let buttonBackgroundID = "buttonBackgroundID"
  private let insets = EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

  @Namespace private var namespaceID
  @Binding private var selection: Option
  @State private var optionIsPressed: [Option.ID: Bool] = [:]

  init(
    options: [Option],
    label: KeyPath<Option, String>,
    selectionColor: Color,
    backgroundColor: Color,
    selection: Binding<Option>
  ) {
    self.options = options
    self.label = label
    self.selectionColor = selectionColor
    self.backgroundColor = backgroundColor
    self._selection = selection
  }

  var body: some View {
    HStack(spacing: interSegmentSpacing) {
      ForEach(Array(zip(options.indices, options)), id: \.1.id) { index, option in
        SegmentButton(
          label: option[keyPath: label],
          selectionColor: selectionColor,
          isSelected: selection == option,
          animation: animation,
          isPressed: .init(
            get: { optionIsPressed[option.id, default: false] },
            set: { optionIsPressed[option.id] = $0 }
          ),
          backgroundID: buttonBackgroundID,
          namespaceID: namespaceID,
          action: { selection = option }
        )
        .zIndex(selection == option ? 0 : 1)
      }
    }
    .padding(insets)
    .onAppear {
      optionIsPressed = Dictionary(uniqueKeysWithValues: options.lazy.map { ($0.id, false) })
    }
    .background(backgroundColor)
    .clipShape(RoundedRectangle(cornerRadius: 14))
  }
}

fileprivate struct SegmentButton: View {

  static let segmentLabelFontSize: CGFloat = 10

  private let label: String
  private let isSelected: Bool
  private let action: () -> Void
  private let backgroundID: String
  private let animation: Animation
  private let selectionColor: Color
  private let namespaceID: Namespace.ID

  @Binding private var isPressed: Bool

  init(
    label: String,
    backgroundID: String,
    selectionColor: Color,
    isSelected: Bool,
    animation: Animation,
    namespaceID: Namespace.ID,
    action: @escaping () -> Void,
    isPressed: Binding<Bool>
  ) {
    self.label = label
    self.backgroundID = backgroundID
    self.selectionColor = selectionColor
    self.isSelected = isSelected
    self.animation = animation
    self.namespaceID = namespaceID
    self.action = action
    self._isPressed = isPressed
  }

  var body: some View {
    Button(action: action) {
      segmentLabel
        .blendMode(.difference)
        .overlay {
          segmentLabel
            .blendMode(.hue)
            .accessibilityHidden(true)
        }
        .overlay {
          segmentLabel
            .blendMode(.overlay)
            .accessibilityHidden(true)
        }
        .background {
          if isSelected {
            selectionColor
              .clipShape(RoundedRectangle(cornerRadius: 10))
              .transition(.offset())
              .matchedGeometryEffect(id: backgroundID, in: namespaceID)
          }
        }
        .animation(animation, value: isSelected)
    }
    .buttonStyle(SegmentPressStyle(isPressed: $isPressed))
    .accessibilityElement(children: .combine)
    .accessibilityAddTraits(isSelected ? .isSelected : [])
    .accessibilityRemoveTraits(isSelected ? [] : .isSelected)
  }

  private var segmentLabel: some View {
    Text(label)
      .font(.system(size: Self.segmentLabelFontSize, weight: .semibold, design: .rounded))
      .foregroundColor(isPressed ? .secondary : .primary)
      .lineLimit(1)
      .padding(.vertical, 4)
      .frame(maxWidth: .infinity)
  }
}

private struct SegmentPressStyle: ButtonStyle {

  @Binding var isPressed: Bool

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .contentShape(Rectangle())
      .onValueChange(of: configuration.isPressed) { newValue in
        isPressed = newValue
      }
  }
}
