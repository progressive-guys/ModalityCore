#if os(iOS)
import SwiftUI

/// A progress-driven bottom sheet for presenting controls above app content.
public struct BottomView<Content: View>: View {
  @Binding private var progress: CGFloat
  private let maxHeight: CGFloat
  private let content: () -> Content

  @State private var dragStartProgress: CGFloat?
  @State private var scrollViewDragging = false

  public init(
    progress: Binding<CGFloat>,
    maxHeight: CGFloat,
    @ViewBuilder content: @escaping () -> Content
  ) {
    _progress = progress
    self.maxHeight = maxHeight
    self.content = content
  }

  private var sheetOffset: CGFloat {
    maxHeight * (1 - progress)
  }

  public var body: some View {
    GeometryReader { _ in
      VStack(spacing: 0) {
        Spacer()

        VStack(spacing: 0) {
          handle

          content()
            .environment(\.bottomViewScrollHandler, BottomViewScrollHandler(
              onOverscroll: handleOverscroll(translation:),
              onOverscrollEnded: handleOverscrollEnded(translation:velocity:)
            ))
        }
        .frame(height: maxHeight)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .offset(y: sheetOffset)
        .gesture(dragGesture)
      }
      .ignoresSafeArea(edges: .bottom)
    }
  }

  private var handle: some View {
    RoundedRectangle(cornerRadius: 2)
      .fill(.secondary.opacity(0.5))
      .frame(width: 36, height: 4)
      .padding(.vertical, 8)
      .frame(maxWidth: .infinity)
  }

  private func handleOverscroll(translation: CGFloat) {
    if !scrollViewDragging {
      scrollViewDragging = true
      dragStartProgress = progress
    }
    let startProgress = dragStartProgress ?? progress
    progress = min(1, max(0, startProgress - translation / maxHeight))
  }

  private func handleOverscrollEnded(translation: CGFloat, velocity: CGFloat) {
    scrollViewDragging = false
    snap(translation: translation, velocity: velocity)
  }

  private var dragGesture: some Gesture {
    DragGesture()
      .onChanged { value in
        let startProgress = dragStartProgress ?? progress
        if dragStartProgress == nil {
          dragStartProgress = progress
        }
        progress = min(1, max(0, startProgress - value.translation.height / maxHeight))
      }
      .onEnded { value in
        snap(
          translation: value.translation.height,
          velocity: value.predictedEndLocation.y - value.location.y
        )
      }
  }

  private func snap(translation: CGFloat, velocity: CGFloat) {
    let threshold = maxHeight * 0.1
    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
      if translation > threshold || velocity > 100 {
        progress = 0
      } else if translation < -threshold || velocity < -100 {
        progress = 1
      } else {
        progress = progress > 0.5 ? 1 : 0
      }
    }
    dragStartProgress = nil
  }
}

public extension View {
  /// Shrinks and lifts content in sync with a `BottomView` opening.
  func bottomViewTransform(progress: CGFloat, height: CGFloat, sheetShare: CGFloat) -> some View {
    let maxOffset = height * (sheetShare / 2)
    let scale = 1.0 - (sheetShare * progress)
    let cornerRadius = 24 * progress
    let offset = -maxOffset * progress

    return clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
      .scaleEffect(scale)
      .offset(y: offset)
  }
}
#endif
