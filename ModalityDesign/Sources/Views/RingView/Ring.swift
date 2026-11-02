import SwiftUI
import Foundation

public struct Ring<Containing: Equatable & Hashable>: Identifiable, Equatable, Hashable {

  public let id: String
  public let wedges: [Wedge]

  public let scale: CGFloat
  public let height: CGFloat
  public let yShift: CGFloat
  public let aspectRatio: CGFloat

  public var innerRadius: CGFloat

  public init(
    id: String,
    wedges: [Wedge],
    innerRadius: CGFloat,
    height: CGFloat,
    yShift: CGFloat = 0,
    scale: CGFloat = 1,
    aspectRatio: CGFloat = 1
  ) {
    self.id = id
    self.wedges = wedges
    self.innerRadius = innerRadius
    self.height = height
    self.yShift = yShift
    self.scale = scale
    self.aspectRatio = aspectRatio
  }

  public var outerRadius: CGFloat { innerRadius + height }
}

extension Ring: Animatable {

  public var animatableData: CGFloat {
    get { innerRadius }
    set { innerRadius = newValue }
  }
}
