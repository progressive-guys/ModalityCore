import SwiftUI

/// Keeps dragging local and sends changes to the binding at most 30 times per second.
/// Sends the final value as soon as editing ends.
public struct ThrottledSlider<Value: BinaryFloatingPoint>: View where Value.Stride: BinaryFloatingPoint {
  @Binding private var value: Value
  private let range: ClosedRange<Value>

  @State private var draftValue: Value?
  @State private var isEditing = false
  @State private var lastCommitDate = Date.distantPast
  @State private var pendingCommitTask: Task<Void, Never>?

  private let commitInterval: TimeInterval = 1.0 / 30.0

  public init(value: Binding<Value>, in range: ClosedRange<Value>) {
    self._value = value
    self.range = range
  }

  public var body: some View {
    Slider(
      value: Binding(get: { currentValue }, set: updateDraftValue),
      in: range,
      onEditingChanged: handleEditingChanged
    )
    .onDisappear { handleEditingChanged(false) }
  }

  private var currentValue: Value {
    draftValue ?? value
  }

  private func updateDraftValue(_ value: Value) {
    draftValue = min(max(value, range.lowerBound), range.upperBound)
    pendingCommitTask?.cancel()
    pendingCommitTask = nil

    let elapsed = Date().timeIntervalSince(lastCommitDate)
    guard elapsed < commitInterval else {
      commit(currentValue)
      return
    }

    let delay = commitInterval - elapsed
    pendingCommitTask = Task { @MainActor in
      try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
      guard !Task.isCancelled else { return }
      pendingCommitTask = nil
      commit(currentValue)
    }
  }

  private func handleEditingChanged(_ isEditing: Bool) {
    self.isEditing = isEditing
    if isEditing {
      draftValue = currentValue
    } else {
      pendingCommitTask?.cancel()
      pendingCommitTask = nil
      commit(currentValue)
      draftValue = nil
    }
  }

  private func commit(_ newValue: Value) {
    if !isEditing { draftValue = nil }
    guard value != newValue else { return }
    value = newValue
    lastCommitDate = Date()
  }
}
