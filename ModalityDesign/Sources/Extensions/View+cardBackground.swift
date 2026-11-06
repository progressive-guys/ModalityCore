import SwiftUI

public extension View {

  func cardBackground(
    paddings: CGFloat = 12,
    cornerRadius: CGFloat = 12,
    fillOpacity: Double = 0.1,
    strokeOpacity: Double = 0.3,
    strokeWidth: CGFloat = 1,
    backgroundColor: Color = .cardsBackgroundColor,
    borderColor: Color = .veryDarkDesaturatedBlue
  ) -> some View {
    modifier(CardBackgroundModifier(
      paddings: paddings,
      cornerRadius: cornerRadius,
      fillOpacity: fillOpacity,
      strokeOpacity: strokeOpacity,
      strokeWidth: strokeWidth,
      backgroundColor: backgroundColor,
      borderColor: borderColor
    ))
  }
}

fileprivate struct CardBackgroundModifier: ViewModifier {

  let paddings: CGFloat
  let borderColor: Color
  let fillOpacity: Double
  let strokeWidth: CGFloat
  let cornerRadius: CGFloat
  let strokeOpacity: Double
  let backgroundColor: Color

  init(
    paddings: CGFloat,
    cornerRadius: CGFloat,
    fillOpacity: Double,
    strokeOpacity: Double,
    strokeWidth: CGFloat,
    backgroundColor: Color,
    borderColor: Color
  ) {
    self.paddings = paddings
    self.cornerRadius = cornerRadius
    self.fillOpacity = fillOpacity
    self.strokeOpacity = strokeOpacity
    self.strokeWidth = strokeWidth
    self.backgroundColor = backgroundColor
    self.borderColor = borderColor
  }

  func body(content: Content) -> some View {
    content
      .padding(paddings)
      .background {
        RoundedRectangle(cornerRadius: cornerRadius)
          .fill(backgroundColor)
          .overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
              .stroke(borderColor, lineWidth: strokeWidth)
          }
      }
  }
}
