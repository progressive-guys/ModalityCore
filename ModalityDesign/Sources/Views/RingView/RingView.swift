import SwiftUI

public struct RingView<Content: Equatable & Hashable>: View {

  private let onWedgeSelection: ((Ring<Content>.Wedge) -> Void)?

  private var ring: Ring<Content>

  public init(
    ring: Ring<Content>,
    onWedgeSelection: ((Ring<Content>.Wedge) -> Void)? = nil
  ) {
    self.ring = ring
    self.onWedgeSelection = onWedgeSelection
  }

  public var body: some View {
    ZStack {
      ForEach(ring.wedges, id: \.id) { wedge in
        WedgeView<Content>(wedge: wedge, ring: ring)
          .onTapGesture {
            onWedgeSelection?(wedge)
          }
          .animation(.wedge, value: wedge.start)
          .animation(.linear, value: wedge.color)
          .transition(.scaleAndFade)
      }
    }
  }
}

extension RingView: @preconcurrency Animatable {

  public var animatableData: Ring<Content>.AnimatableData {
    get { ring.animatableData }
    set { ring.animatableData = newValue }
  }
}
